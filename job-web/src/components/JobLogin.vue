<template>
    <div class="content-box">
        <div class="login-title">
            <div class="login-txt">登录</div>
        </div>
        <div class="username">
            <el-form :model="ruleForm2" status-icon :rules="rules2" ref="ruleForm2" label-width="100px" class="demo-ruleForm">
                <el-form-item label="用户名" prop="userName">
                    <el-input v-model.number="ruleForm2.userName"></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="pass">
                    <el-input type="password" v-model="ruleForm2.pass" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="submitForm('ruleForm2')">提交</el-button>
                    <el-button @click="resetForm('ruleForm2')">重置</el-button>
                </el-form-item>
            </el-form>
            <div class="link">
                <div class="link-left" @click="forgetPass">忘记密码？</div>
                <div class="link-right" @click="jumpRigister">注册账号</div>
            </div>
        </div>

    </div>
</template>

<script>
    import { login } from '../utils/index';
    export default {
        name: "job-login",
        data() {
            var checkUserName = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('用户名不能为空'));
                } else {
                    callback();
                }
            };

            var validatePass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请输入密码'));
                } else {
                    callback();
                }
            };
            return {
                ruleForm2: {
                    pass: '',
                    userName: ''
                },
                rules2: {
                    pass: [
                        { validator: validatePass, trigger: 'blur' }
                    ],
                    userName: [
                        { validator: checkUserName, trigger: 'blur' }
                    ]
                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    console.log(valid)
                    if (valid) {
                        login({
                            username: this.ruleForm2.userName,
                            password: this.ruleForm2.pass
                        }).then((res) => {
                            let data = res.data;
                            if(data.code == 0){
                                let userInfo = data.data
                                localStorage.recruitUserInfo = JSON.stringify(userInfo)
                                this.$alert("登录成功").then(() => {
                                    this.$router.push({
                                        path: '/'
                                    })
                                })
                                // JSON.parse(localStorage.recruitUserInfo)
                            }else if(data.code == 1){
                                this.$alert(data.errMsg)
                            }
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
            // 跳转到忘记密码
            forgetPass() {
                this.$alert('请联系管理员');
            },
            // 跳转到注册
            jumpRigister() {
                this.$router.push({
                    path: '/user/register'
                })
            }
        }
    }
</script>

<style lang="stylus" scoped>
    .login-title
        height 59px
        border-bottom 1px solid #f0f0f0
        margin-bottom 20px
        width 304px
        margin-left 14px
        .login-txt
            width 100px
            height 40px
            line-height 40px
            font-size 22px
            color #a8a0b7
            background #fff
            text-align center
            position absolute
            top 38px
            left 170px
    .link
        display flex
        justify-content space-between
        cursor pointer
        font-size 12px
        color rgb(46, 130, 255)

</style>