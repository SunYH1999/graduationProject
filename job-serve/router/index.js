const Router = require('koa-router')();
const { 
    user,
    resume,
    company,
    category,
    job,
	evaluate
} = require('../api');

const types = ['get', 'post']
const get = [
]

const post = [
    ['/login', user.login],
    ['/register', user.register],

    ['/resume/list', resume.list],
    ['/resume/create', resume.create],
    ['/resume/edit', resume.edit],
    ['/resume/delete', resume.del],
    ['/resume/detail', resume.detail],
    ['/resume/my', resume.my],

    ['/company/list', company.list],
    ['/company/create', company.create],
    ['/company/edit', company.edit],
    ['/company/delete', company.del],
    ['/company/detail', company.detail],
    ['/company/status', company.status],

    ['/category/list', category.list],
    ['/category/create', category.create],
    ['/category/edit', category.edit],
    ['/category/delete', category.del],
    ['/category/detail', category.detail],
    
    ['/job/list', job.list],
	['/job/searchlist', job.searchlist],
    ['/job/create', job.create],
	['/job/del', job.del],
    ['/job/edit', job.edit],
    ['/job/delete', job.del],
    ['/job/detail', job.detail],
    ['/job/delivery', job.delivery],
    ['/job/my', job.my],
	['/evaluate/create', evaluate.create]
    
    
]

const router = {
    get,
    post
}

types.forEach(type => {
    router[type].forEach(route => {
        const [url, api] = route
        Router.post(url, api)
    })
})


module.exports = Router