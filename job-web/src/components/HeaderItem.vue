<template>
    <!--头部组建-->
    <div class="HeaderItem">
        <div class="content">
            <div class="logo" @click="jumpHome">
                <img src="../assets/img/logo.png" alt="">
            </div>
            <div class="button">
                <el-button type="primary" @click="jumpLogin" v-if="this.username == ''">登录</el-button>
                <el-button type="success" @click="jumpRigister" v-if="this.username == ''">注册</el-button>
                <span v-if="this.username != ''" class="username">{{this.username}}</span>
                <el-button type="success" v-if="this.username != ''" @click="jumpExit">退出登录</el-button>
            </div>
        </div>
    </div>
</template>

<script>
    import { delectUserInfo, getUserInfo } from '../utils/function'
    export default {
        name: "HeaderItem",
        data() {
            return {
                username: ''
            }
        },
        methods: {
            // 点击Logo跳转到首页
            jumpHome() {
                this.$router.push({
                    path: '/'
                })
            },
            // 跳转到登录
            jumpLogin() {
                this.$router.push({
                    path: '/user/login'
                })
            },
            // 跳转到注册
            jumpRigister() {
                this.$router.push({
                    path: '/user/register'
                })
            },
            // 退出登录
            jumpExit() {
                delectUserInfo()
            }
        },
        mounted() {
            let userInfo = getUserInfo()
            console.log(userInfo)
            if(userInfo){
                this.username = userInfo.username
            }
        }
    }
</script>

<style scoped>
    .content {
		padding-top: 20px;
        height: 70px;
        line-height: 70px;
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
	}
        
    .logo {
		height: 100px;
	}
            
    img {
		position: absolute;
		left: 20px;
		height: 80px;
	}
                
    .username {
		margin-right: 20px;
	}
        
</style>