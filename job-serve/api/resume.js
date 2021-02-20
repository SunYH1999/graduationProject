const {resErr} = require('../utils');
const { Resume, User, Job } = require('../db');

// 简历列表
const list = async (ctx) => {
    try {
        const { page, pageSize } = ctx.request.body

        const {count: total, rows: dataList} = await Resume.findAndCount({
            include: [{
                model: User,
                attributes: ['id', 'username', 'mobile', 'email'],
            }],
            offset: page * pageSize || 0,
      limit: pageSize || 10
        });

        ctx.body = {
            code: 0,
            total,
            dataList
        }
    } catch (err) {
        resErr(ctx, err)
    }
}

// 简历详情
const detail = async (ctx) => {
    try {
        const { id } = ctx.request.body

        const userId = id ? null : ctx.user.id
        const data = await Resume.findOne({
            where: {
                $or: [
                    {id},
                    {userId},
                ]
            }
        });

        ctx.body = {
            code: 0,
            data
        }
    } catch (err) {
        resErr(ctx, err)
    }
}

// 发布简历
const create = async (ctx) => {
    try {
        if(ctx.user.role != 1){
            throw '只有求职者才可以进行此操作'
        }
        const {
            name,
            sex,
            workYear,
            address,
            mobile,
            email,
            hope,
            salary,
            work,
            education,
            personal
        } = ctx.request.body
    
        const year = ctx.request.body.year ? new Date(ctx.request.body.year) : null

        const user = ctx.user

        await user.createResume({
            name,
            sex,
            year,
            workYear,
            address,
            mobile,
            email,
            hope,
            salary,
            work,
            education,
            personal
        })

        ctx.body = {
            code: 0
        }
    } catch (err) {
        resErr(ctx, err)
    }
}

// 编辑简历
const edit = async (ctx) => {
    try {
        if(ctx.user.role != 1){
            throw '只有求职者才可以进行此操作'
        }
        const {
            id,
            name,
            sex,
            workYear,
            address,
            mobile,
            email,
            hope,
            salary,
            work,
            education,
            personal
        } = ctx.request.body
    
        const year = ctx.request.body.year ? new Date(ctx.request.body.year) : null

        const resume = await Resume.findOne({
            where: {
                id
            }
        })

        if(!resume){
            throw '数据不存在'
        }
        await resume.update({
            name,
            sex,
            year,
            workYear,
            address,
            mobile,
            email,
            hope,
            salary,
            work,
            education,
            personal,
        })

        ctx.body = {
            code: 0
        }
    } catch (err) {
        resErr(ctx, err)
    }
}

// 删除简历
const del = async (ctx) => {
    try {
        if(ctx.user.role != 1){
            throw '只有求职者才可以进行此操作'
        }
        const {
            id
        } = ctx.request.body
    
        const resume = await Resume.findOne({
            where: {
                id
            }
        })

        if(!resume){
            throw '数据不存在'
        }

        await resume.destroy()

        ctx.body = {
            code: 0
        }
    } catch (err) {
        resErr(ctx, err)
    }
}

// 我收到的投递
const my = async (ctx) => {
    try {
        if(ctx.user.role != 2){
            throw '只有公司用户才可以进行此操作'
        }
        const {id: userId} = ctx.user
        let jobs = await Job.findAll({
            where: {
                userId
            },
            include: [{
                model: Resume,
                include: [Job]
            }]
        })

        let dataList = []
        jobs.forEach(o => {
            dataList = [...dataList, ...o.resumes]
        })
        
        ctx.body = {
            code: 0,
            dataList
        }
    } catch (err) {
        resErr(ctx, err)
    }
}

module.exports = {
    list,
    create,
    edit,
    del,
    detail,
    my
}
