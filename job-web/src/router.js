import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import User from './views/User.vue'
import JobLogin from './components/JobLogin.vue'
import JobRegister from './components/JobRegister.vue'
import WantJob from './components/WantJob.vue'
import WantMan from './components/WantMan.vue'
import SuperAdmin from './components/SuperAdmin.vue'
import JobDetails from './components/JobDetails.vue'
import PostList from './components/PostList.vue'
import PostAddEditor from './components/PostAddEditor.vue'
import GetResume from './components/GetResume.vue'
import Company from './components/Company.vue'
import ResumeEdit from './components/ResumeEdit.vue'
import MeSendPost from './components/MeSendPost'
import CompanyAudit from './components/CompanyAudit.vue'
import Category from './components/Category.vue'

Vue.use(Router)

export default new Router({
    routes: [
        {
            path: '/',
            name: 'home',
            component: Home,
            children: [
                {
                    path: '/wantman',
                    name: 'wantman',
                    component: WantMan
                },{
                    path: '/wantjob',
                    name: 'wantjob',
                    component: WantJob
                },{
                    path: '/superadmin',
                    name: 'SuperAdmin',
                    component: SuperAdmin
                },
                {
                    path: '/jobdetails',
                    name: 'jobdetails',
                    component: JobDetails
                },
                {
                    path: '/company',
                    name: 'company',
                    component: Company
                },
                {
                    path: '/postlist',
                    name: 'postlist',
                    component: PostList
                },
                {
                    path: '/postaddeditor',
                    name: 'Postaddeditor',
                    component: PostAddEditor
                },
                {
                    path: '/getresume',
                    name: 'GetResume',
                    component: GetResume
                },
                {
                    path: '/resumeedit',
                    name: 'ResumeEdit',
                    component: ResumeEdit
                },
                {
                    path: '/mesendpost',
                    name: 'MeSendPost',
                    component: MeSendPost
                },
                {
                    path: '/companyaudit',
                    name: 'CompanyAudit',
                    component: CompanyAudit
                },
                {
                    path: '/category',
                    name: 'Category',
                    component: Category
                }
            ]
        },
        {
            path: '/user',
            name: 'user',
            component: User,
            children: [
                {
                    path: 'login',
                    name: 'login',
                    component: JobLogin
                },
                {
                    path: 'register',
                    name: 'register',
                    component: JobRegister
                }
            ]
        }
    ]
})
