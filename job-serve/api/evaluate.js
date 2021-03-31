// const {genUuid, resErr} = require('../utils');
const { Evaluate } = require('../db');

// 提交评价
const create = async (ctx) => {
    try {
        const {
            companyname,
            value1,
            value2,
            value3,
            value4,
			value5,
			text
        } = ctx.request.body
    
        const user = ctx.user
        
        await user.createEvaluate({
            companyname,
            value1,
            value2,
            value3,
            value4,
            value5,
            text
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

module.exports = {
    create,
}