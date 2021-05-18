const { Jobing, Job, Category, User, Company, Resume } = require('../db');

// const Op = Sequelize.Op;
// 岗位列表
const list = async (ctx) => {
    try {
        const { page, pageSize } = ctx.request.body

        const {count: total, rows: dataList} = await Job.findAndCount({
            include: [{
                model: User,
                attributes: ['id', 'username', 'mobile', 'email'],
                include: [{
                    model: Company,
                    attributes: ['id', 'name', 'address', 'capital', 'charge', 'identification'],
                }]
            }, {
                model: Category,
                attributes: ['id', 'name']
            }],
            attributes: ['id', 'name', 'workYear', 'salary', 'number', 'describe', 'condition', 'updatedAt'],
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



// 数据
const data = async (ctx) => {
    try {
        const { page, pageSize } = ctx.request.body

        const {count: total, rows: dataList} = await Job.findAndCount({
            include: [{
                model: User,
                attributes: ['id', 'username', 'mobile', 'email'],
                include: [{
                    model: Company,
                    attributes: ['id', 'name', 'address', 'capital', 'charge', 'identification'],
                }]
            }, {
                model: Category,
                attributes: ['id', 'name']
            }],
            attributes: ['id', 'name', 'workYear', 'salary', 'number', 'describe', 'condition', 'updatedAt'],
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






//搜索列表
const searchlist = async (ctx) => {
	const Sequelize = require('sequelize');
	const Op = Sequelize.Op;
    try {
	  const { page, pageSize, key='' } = ctx.request.body
	  
	    const {count: total, rows: dataList} = await Job.findAndCount({
			
	        include: [{
	            model: User,
	            attributes: ['id', 'username', 'mobile', 'email'],
	            include: [{
	                model: Company,
	                attributes: ['id', 'name', 'address', 'capital', 'charge', 'identification'],
	            }]
	        }, {
	            model: Category,
	            attributes: ['id', 'name']
	        }],
			where: {
			   // name: key,
			   name: {
				   [Op.like]: `%${key}%`
			   }
			  },
	        attributes: ['id', 'name', 'workYear', 'salary', 'number', 'describe', 'condition', 'updatedAt'],
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



// 岗位详情
const detail = async (ctx) => {
    try {
        const { id } = ctx.request.body

        const userId = id ? null : ctx.user.id
        const data = await Job.findOne({
            where: {
                $or: [
                    {id},
                    {userId},
                ]
            },
            include: [{
                model: User,
                attributes: ['id', 'username', 'mobile', 'email'],
                include: [{
                    model: Company,
                    attributes: ['id', 'name', 'address', 'capital', 'charge', 'identification'],
                }]
            }, {
                model: Category,
                attributes: ['id', 'name']
            }],
            attributes: ['id', 'name', 'workYear', 'salary', 'number', 'describe', 'condition', 'updatedAt'],
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

// 发布岗位
const create = async (ctx) => {
    try {
        if(ctx.user.role != 2){
            throw '只有公司用户才可以进行此操作'
        }
        const {
            name,
            categoryId,
            workYear,
            salary,
            number,
            describe,
            condition,
        } = ctx.request.body
    

        const user = ctx.user
        await user.createJob({
            name,
            categoryId,
            workYear,
            salary,
            number,
            describe,
            condition,
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

// 编辑岗位
const edit = async (ctx) => {
    try {
        if(ctx.user.role != 2){
            throw '只有公司用户才可以进行此操作'
        }
        const {
            id,
            name,
            categoryId,
            workYear,
            salary,
            number,
            describe,
            condition,
        } = ctx.request.body

        const job = await Job.findOne({
            where: {
                id
            }
        })

        if(!job){
            throw '数据不存在'
        }
        await job.update({
            name,
            categoryId,
            workYear,
            salary,
            number,
            describe,
            condition,
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

// 删除岗位
const del = async (ctx) => {
    try {
        if(ctx.user.role != 2){
            throw '只有公司用户才可以进行此操作'
        }
        const {
            id
        } = ctx.request.body
    
        const job = await Job.findOne({
            where: {
                id
            }
        })

        if(!job){
            throw '数据不存在'
        }

        await job.destroy()

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

//查找岗位
// const findJob = async () => {
//   // 查找所有
//   const allUser = await UserModel.findAll()

//   // 按id查找
//   const oneUser = await UserModel.findById(id)

//   // 按条件查询
//   const someUser = await UserModel.findAll({
//     where: {
//       // 模糊查询
//       name: {
//         $like: '%小%',
//       },

//       // 精确查询
//       password: 'root',
//     }
//   })

//   // 分页查询
//   const size = 10 // 每页10条数据
//   const page = 1 // 页数
//   const pageUser = await UserModel.findAndCountAll({
//     where: {
//       name: {
//         $like: '%小%',
//       },
//     },
//     limit: size,
//     offset: size * (page - 1),
//   })
// }

// 投递简历
const delivery = async (ctx) => {
    try {
        if(ctx.user.role != 1){
            throw '只有求职者才可以进行此操作'
        }
        const {
            jobId,
            resumeId,
        } = ctx.request.body
        
        const job = await Job.findOne({
            where: {
                id: jobId
            }
        })

        if(!job){
            throw '职位不存在'
        }

        const resume = await Resume.findOne({
            where: {
                id: resumeId
            }
        })

        if(!resume){
            throw '简历不存在'
        }
        await job.addResume(resume)

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

// 我投递过的岗位
const my = async (ctx) => {
    try {
        const {id: userId} = ctx.user
        let dataList = []
        if(ctx.user.role == 1){
            const resume = await Resume.findOne({
                where: {
                    userId
                }
            })
    
            if(!resume){
                throw '您未完善简历信息'
            }
            
            dataList = await resume.getJobs({
                include: [{
                    model: User,
                    attributes: ['id', 'username', 'mobile', 'email'],
                    include: [{
                        model: Company,
                        attributes: ['id', 'name', 'address', 'capital', 'charge', 'identification'],
                    }]
                }, {
                    model: Category,
                    attributes: ['id', 'name']
                }],
                attributes: ['id', 'name', 'workYear', 'salary', 'number', 'describe', 'condition', 'updatedAt'],
            });
        } else {
            dataList = await Job.findAll({
                where: {
                    userId
                },
                include: [{
                    model: Category,
                    attributes: ['id', 'name']
                }],
            });
        }
        

        ctx.body = {
            code: 0,
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

module.exports = {
    list,
	searchlist,
    create,
    edit,
    del,
    detail,
    delivery,
    my
}
