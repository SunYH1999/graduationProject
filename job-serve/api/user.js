const {genUuid, resErr} = require('../utils');
const { User } = require('../db');

// 登录
const login = async (ctx) => {
    try {
        const { username, password } = ctx.request.body
        const token = genUuid()
    
        const data = await User.findOne({
            where: {
                username,
                password
            }
        });

        if(!data){
            throw '密码或用户名错误'
        }

        data.token = token
        await data.save()
        ctx.body = {
            code: 0,
            data
        }
    } catch (err) {
        resErr(ctx, err)
    }
}

// 注册
const register = async (ctx) => {
    try {
        const {
            username,
            email,
            mobile,
            password,
            role
        } = ctx.request.body
    
        await User.create({
            username,
            email,
            mobile,
            password,
            role
        })
    
        ctx.body = {
            code: 0
        }
    } catch (err) {
        resErr(ctx, err)
    }
    
}

//数据
const data = async (ctx) => {
	try {	  
	    const {count: total, rows: dataList} = await Resumes.findAndCount({
			where: {
			    sex: 1
			  },
	        
	        //attributes: ['id', 'name', 'workYear', 'salary', 'number', 'describe', 'condition', 'updatedAt'],
	        offset: page * pageSize || 0,
			limit: pageSize || 10
	    });
	  
	    ctx.body = {
	        code: 0,
	        total,
	        man: total/dataList,
			woman: (dataList-total)/dataList
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
    login,
    register
}
