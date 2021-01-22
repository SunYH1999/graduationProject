<template>
    <div class="home">
        <HeaderItem/>
        <NavMenu/>
        <router-view/>
        <FooterItem/>
    </div>
</template>

<script>
    // @ is an alias to /src
    import HeaderItem from '@/components/HeaderItem.vue'
    import NavMenu from '@/components/NavMenu.vue'
    import FooterItem from '@/components/FooterItem.vue'
    import { getUserInfo } from '../utils/function'

    export default {
        name: 'home',
        components: {
            HeaderItem,
            NavMenu,
            FooterItem
        },
        watch:{
            "$route.path":function (newVal, oldVal) {
                if(newVal === '/'){
                    this.jumpRouter()
                }
            }
        },
        methods: {
            jumpRouter(){
				// 如果没登录
                if(!localStorage.recruitUserInfo){
                    this.$router.push({
                        path: '/user/login'
                    })
                }
                let userInfo = getUserInfo()
                console.log(`userInfo.role = ${userInfo.role}`)
				
				// 求职者1，招聘者2，超级管理员3
                if(userInfo.role == 1){
                    this.$router.push({
                        path: '/wantjob'
                    })
                }else if(userInfo.role == 2){
                    this.$router.push({
                        path: '/wantman'
                    })
                }else if(userInfo.role == 3){
                    this.$router.push({
                        path: '/superadmin'
                    })
                }else{
                    this.$router.push({
                        path: '/user/login'
                    })
                }
            }
        },
        mounted() {
            this.jumpRouter()
        }
    }
</script>

<style lang="stylus" scoped>
    .home
        width 1440px
        min-width 1440px
        margin 0 auto
        position relative
</style>
