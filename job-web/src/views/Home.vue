<template>
    <div class="home">
        <HeaderItem/>
		<Slider />
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
	import Slider from '@/components/Slider.vue'
    export default {
        name: 'home',
        components: {
            HeaderItem,
            NavMenu,
            FooterItem,
			Slider
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
                if(!localStorage.recruitUserInfo){
                    this.$router.push({
                        path: '/user/login'
                    })
                }
                let userInfo = getUserInfo()
                console.log(`userInfo.role = ${userInfo.role}`)

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

<style scoped>
	* {
		margin: 0;
		padding: 0;
	}
	html, body {
		height: 100%;
		overflow: hidden;
	}
    .home {
		background:linear-gradient(to right, #bb313e25, #bb313e25, #d7222925, #dd4a1625, #e4761525, #f5c50025, #f0e92725, #b1ce2425, #48a93525, #03944525, #157c4f25, #176a5825, #1b556325, #1d386f25, #1d386f25, #20277825, #52266325, #8a244b25);
		/* background: linear-gradient(91deg,#f1eefc,#9dc6ff 70%,#a5bcff); */
		/* background: linear-gradient(135deg,#56c8ff,#6f99fc) no-repeat; */
		width: 100%;
		min-width: 1440px;
		height: 100%;
		margin: 0 auto;
		position: relative;
	}        
</style>
