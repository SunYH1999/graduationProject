import { post } from './ajax'

// 线上环境地址
const baseUrl = 'http://localhost:3013'

// 注册账号
export const register = data => post(`${baseUrl}/register`, data);

// 登录账号
export const login = data => post(`${baseUrl}/login`, data);

//提交评价
export const createEvaluate = data => post(`${baseUrl}/evaluate/create`, data);

// 获取公司
export const getCompanyDetail = data => post(`${baseUrl}/company/detail`, data);

// 创建公司
export const createCompany = data => post(`${baseUrl}/company/create`, data);

// 编辑公司
export const editCompany = data => post(`${baseUrl}/company/edit`, data);

//审核公司列表
export const getCompanyList = data => post(`${baseUrl}/company/list`, data);

//审核公司
export const examineCompany = data => post(`${baseUrl}/company/status`, data);

//添加岗位
export const createJob = data => post(`${baseUrl}/job/create`, data);

//删除岗位
export const deleteJob = data => post(`${baseUrl}/job/del`, data);

//获取我公司下的岗位列表
export const getMyJobList = data => post(`${baseUrl}/job/my`, data);

// 编辑岗位
export const editJob = data => post(`${baseUrl}/job/edit`, data);

// 获取岗位详情
export const getJobDetail = data => post(`${baseUrl}/job/detail`, data);

// 获取所有发布岗位
export const getJobList = data => post(`${baseUrl}/job/list`, data);

// 获取搜索的发布岗位
export const getsearchJobList = data => post(`${baseUrl}/job/searchlist`, data);

//获取分类列表
export const getCategoryList = data => post(`${baseUrl}/category/list`, data);

//添加分类
export const createCategory = data => post(`${baseUrl}/category/create`, data);

//编辑分类
export const editCategory = data => post(`${baseUrl}/category/edit`, data);

//删除分类
export const deleteCategory = data => post(`${baseUrl}/category/delete`, data);

//添加简历
export const createResume = data => post(`${baseUrl}/resume/create`, data);

//获取个人简历
export const getMyResume = data => post(`${baseUrl}/resume/detail`, data);

//编辑简历
export const editResume = data => post(`${baseUrl}/resume/edit`, data);

//投递简历
export const deliveryJob = data => post(`${baseUrl}/job/delivery`, data);

//我投递过的岗位
export const getMyJob = data => post(`${baseUrl}/job/my`, data);

//我收到的简历
export const MygetResume = data => post(`${baseUrl}/resume/my`, data);

// 获取用户简历列表
export const MyManResumeList = data => post(`${baseUrl}/resume/list`, data);