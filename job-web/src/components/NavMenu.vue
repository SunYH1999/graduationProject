<template>
    <div class="navMenu">
        <el-menu text-color="gray" active-text-color="black" :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
            <el-menu-item index="1">首页</el-menu-item>
            <el-submenu index="2" v-if="this.role != 3">
                <template slot="title">岗位</template>
                <el-menu-item index="2-1" v-if="this.role == 2">岗位列表</el-menu-item>
                <el-menu-item index="2-2" v-if="this.role == 2">添加岗位</el-menu-item>
                <el-menu-item index="2-3" v-if="this.role == 1">我投递过的岗位</el-menu-item>
            </el-submenu>
            <el-submenu index="3" v-if="this.role != 3">
                <template slot="title">简历</template>
                <el-menu-item index="3-1" v-if="this.role == 1">我的简历</el-menu-item>
                <el-menu-item index="3-2" v-if="this.role == 2">我收到的的简历</el-menu-item>
            </el-submenu>
			<el-menu-item index="6" v-if="this.role != 3">资讯</el-menu-item>
            <el-submenu index="4" v-if="this.role == 2">
                <template slot="title">公司</template>
                <el-menu-item index="4-1">我的公司</el-menu-item>
            </el-submenu>
            <el-submenu index="5" v-if="this.role == 3">
                <template slot="title">管理</template>
                <el-menu-item index="5-1">公司列表</el-menu-item>
                <el-menu-item index="5-2">分类管理</el-menu-item>
            </el-submenu>
			<el-submenu index="7" v-if="this.role == 3">
			    <template slot="title">大数据</template>
			    <el-menu-item index="7-1">招聘数据</el-menu-item>
			    <el-menu-item index="7-2">求职数据</el-menu-item>
			</el-submenu>
        </el-menu>
    </div>
</template>

<script>
    import { getUserInfo } from '../utils/function'
    export default {
        name: "nav-menu",
        data() {
            return {
                activeIndex: '1',
                role: 1
            };
        },
        methods: {
            handleSelect(key, keyPath) {

                if(key == '1'){
                    // 跳转到首页
                    this.$router.push({
                        path: '/'
                    })
                }else if(key == '2-1'){
                    // 跳转至岗位列表
                    this.$router.push({
                        path: '/postlist'
                    })
                }else if(key == '2-2'){
                    // 跳转至岗位列表
                    this.$router.push({
                        path: '/postaddeditor'
                    })
                }else if(key == '2-3'){
                    // 跳转至我投递的岗位
                    this.$router.push({
                        path: '/mesendpost'
                    })
                }else if(key == '3-1'){
                    // 跳转至我的简历
                    this.$router.push({
                        path: '/resumeedit'
                    })
                }else if(key == '3-2'){
                    // 跳转至我收到的简历
                    this.$router.push({
                        path: '/getresume'
                    })
                }else if(key == '4-1'){
                    // 跳转至我的公司
                    this.$router.push({
                        path: '/company'
                    })
                }else if(key == '5-1'){
                    // 跳转至公司审核
                    this.$router.push({
                        path: '/companyaudit'
                    })
                }else if(key == '5-2'){
                    // 跳转至公司审核
                    this.$router.push({
                        path: '/category'
                    })
                }else if(key == '6'){
                    // 跳转至资讯
                    this.$router.push({
                        path: '/info'
                    })
                }else if(key == '7-1'){
                    // 跳转至资讯
                    this.$router.push({
                        path: '/datainfoz'
                    })
                }else if(key == '7-2'){
                    // 跳转至资讯
                    this.$router.push({
                        path: '/datainfoq'
                    })
                }
            }
        },
        mounted() {
            let userInfo = getUserInfo()
            console.log(`userInfo.role= ${userInfo.role}`)
            if(userInfo.role == 1){
                console.log("我是求职者")
                this.role = 1
            }else if(userInfo.role == 2){
                console.log("我是招募者")
                this.role = 2
            }else if(userInfo.role == 3){
                console.log("我是超级管理员")
                this.role = 3
            }else{
                this.$alert("验证失败,请重新登录").then(() => {
                    this.$router.push({
                        path: '/user/login'
                    })
                })
            }
        }
    }
</script>

<style scoped>
    .navMenu {
		margin-bottom: 30px;
	}
</style>