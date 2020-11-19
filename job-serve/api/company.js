const { Company } = require('../db');

// 公司列表
const list = async (ctx) => {
	
	try {
		const { page, pageSize } = ctx.request.body

		const { count: total, rows: dataList } = await Company.findAndCount({
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

// 公司详情
const detail = async (ctx) => {
	try {
		const { id } = ctx.request.body

		const userId = id ? null : ctx.user.id
		const data = await Company.findOne({
			where: {
				$or: [
					{ id },
					{ userId },
				]
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

// 发布公司
const create = async (ctx) => {
	try {
		if(ctx.user.role == 1){
			throw '权限不足'
		}
		const {
			name,
			address,
			capital,
			charge,
			identification,
		} = ctx.request.body

		const user = ctx.user

		await user.createCompany({
			name,
			address,
			capital,
			charge,
			identification,
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

// 编辑公司
const edit = async (ctx) => {
	try {
		if(ctx.user.role == 1){
			throw '权限不足'
		}
		const {
			id,
			name,
			address,
			capital,
			charge,
			identification,
		} = ctx.request.body

		const company = await Company.findOne({
			where: {
				id
			}
		})

		if (!company) {
			throw '数据不存在'
		}
		await company.update({
			name,
			address,
			capital,
			charge,
			identification,
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

// 删除公司
const del = async (ctx) => {
	try {
		if(ctx.user.role == 1){
			throw '权限不足'
		}
		const {
			id
		} = ctx.request.body

		const company = await Company.findOne({
			where: {
				id
			}
		})

		if (!company) {
			throw '数据不存在'
		}

		await company.destroy()

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

// 审核公司
const status = async (ctx) => {
	try {
		if(ctx.user.role == 1 || ctx.user.role == 2){
			throw '权限不足'
		}
		const {
			id,
			status
		} = ctx.request.body

		const company = await Company.findOne({
			where: {
				id
			}
		})

		if (!company) {
			throw '数据不存在'
		}
		await company.update({
			status
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
	list,
	create,
	edit,
	del,
	detail,
	status
}
