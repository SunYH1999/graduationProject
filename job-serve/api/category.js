const { Category } = require('../db');

// 分类列表
const list = async (ctx) => {
    try {
        const { page, pageSize } = ctx.request.body

        const {count: total, rows: dataList} = await Category.findAndCount({
            offset: page * pageSize || 0,
      limit: pageSize || 10
        });

        ctx.body = {
            code: 0,
            total,
            dataList
        }
    } catch (err) {
        console.log(err)
        ctx.body = {
            code: 1,
            err
        }
    }
}

// 分类详情
const detail = async (ctx) => {
    try {
        const { id } = ctx.request.body

        const data = await Category.findOne({
            where: {
                id
            }
        });

        ctx.body = {
            code: 0,
            data
        }
    } catch (err) {
        console.log(err)
        ctx.body = {
            code: 1,
            err
        }
    }
}

// 新增分类
const create = async (ctx) => {
    try {
        const {
            name,
        } = ctx.request.body


        await Category.create({
            name,
        })

        ctx.body = {
            code: 0
        }
    } catch (err) {
        console.log(err)
        ctx.body = {
            code: 1,
            err
        }
    }
}

// 编辑分类
const edit = async (ctx) => {
    try {
        const {
            id,
            name,
        } = ctx.request.body

        const category = await Category.findOne({
            where: {
                id
            }
        })

        if(!category){
            throw '数据不存在'
        }
        await category.update({
            name,
        })

        ctx.body = {
            code: 0
        }
    } catch (err) {
        console.log(err)
        ctx.body = {
            code: 1,
            err
        }
    }
}

// 删除简历
const del = async (ctx) => {
    try {
        const {
            id
        } = ctx.request.body
    
        const category = await Category.findOne({
            where: {
                id
            }
        })

        if(!category){
            throw '数据不存在'
        }

        await category.destroy()

        ctx.body = {
            code: 0
        }
    } catch (err) {
        console.log(err)
        ctx.body = {
            code: 1,
            err
        }
    }
}
module.exports = {
    list,
    create,
    edit,
    del,
    detail
}
