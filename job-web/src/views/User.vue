<template>
    <div class="user">
        <div class="banner">
            <img src="../assets/img/zhilianBanner.jpg" alt="">
        </div>
        <div class="top">
            <div class="top-left">
                <img src="../assets/img/logo.png" alt="" @click="jumpHome">
            </div>
            <div class="top-right">
                联系电话：18888888888
            </div>
        </div>
        <div class="content">
            <router-view />
        </div>
    </div>
</template>

<script>
    import Login from '@/components/JobLogin.vue'
    import Register from '@/components/JobRegister.vue'
    export default {
        name: "user",
        components: {
            Login,
            Register
        },
        data() {
            var checkUserName = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('用户名不能为空'));
                } else {
                    callback();
                }
            };
            var checkEmail = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('邮箱不能为空'));
                } else {
                    callback();
                }
            };
            var validatePass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入密码'));
                } else {
                    if (this.ruleForm2.checkPass !== '') {
                        this.$refs.ruleForm2.validateField('checkPass');
                    }
                    callback();
                }
            };
            var validatePass2 = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入密码'));
                } else if (value !== this.ruleForm2.pass) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };
            return {
                ruleForm2: {
                    pass: '',
                    checkPass: '',
                    userName: '',
                    email: ''
                },
                rules2: {
                    pass: [
                        { validator: validatePass, trigger: 'blur' }
                    ],
                    checkPass: [
                        { validator: validatePass2, trigger: 'blur' }
                    ],
                    userName: [
                        { validator: checkUserName, trigger: 'blur' }
                    ],
                    email: [
                        { validator: checkEmail, trigger: 'blur' }
                    ]
                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    console.log(valid)
                    if (valid) {
                        alert('submit!');
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
            // 点击Logo跳转到首页
            jumpHome() {
                this.$router.push({
                    path: '/'
                })
            }
        }
    }
</script>

<style lang="stylus" scoped>
    .user
        width 1440px
        min-width 1440px
        margin 0 auto
        position relative
        .banner
            text-align center
        .top
            width 1440px
            height 70px
            line-height 70px
            position absolute
            top 20px
            .top-left
                position absolute
                top 0
                left 0
                img
                    width 70px
                    height 70px
            .top-right
                position absolute
                top 0
                right 0
                font-size 12px
                color darkgrey
        .content
            width 340px
            min-height 372px
            background #fff
            position absolute
            top 160px
            left 750px
            padding 0px 45px 25px
            box-shadow 0 0 30px #eee



</style>