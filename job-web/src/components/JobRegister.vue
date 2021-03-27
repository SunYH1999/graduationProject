<template>
    <div class="content-box">
        <div class="login-title">
            <div class="login-txt">注册</div>
        </div>
        <div class="username">
            <el-form :model="ruleForm2" status-icon :rules="rules2" ref="ruleForm2" label-width="100px" class="demo-ruleForm">
                <el-form-item label="用户名" prop="userName">
                    <el-input v-model.number="ruleForm2.userName"></el-input>
                </el-form-item>

                <el-form-item label="手机号码" prop="telPhone">
                    <el-input v-model="ruleForm2.telPhone"></el-input>
                </el-form-item>

                <el-form-item label="密码" prop="pass">
                    <el-input type="password" v-model="ruleForm2.pass" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="确认密码" prop="checkPass">
                    <el-input type="password" v-model="ruleForm2.checkPass" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="Email:" prop="buyerEmail" required>
                    <el-input v-model="ruleForm2.buyerEmail"></el-input>
                </el-form-item>

                <el-form-item label="我想成为">
                    <el-radio-group v-model="ruleForm2.resource">
                        <el-radio label="1">求职者</el-radio>
                        <el-radio label="2">招聘者</el-radio>
                    </el-radio-group>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="submitForm('ruleForm2')">提交</el-button>
                    <el-button @click="resetForm('ruleForm2')">重置</el-button>
                </el-form-item>
            </el-form>
            <div class="link">
                <div class="link-right" @click="jumpLogin">已有账号,去登陆</div>
            </div>
        </div>

    </div>
</template>

<script>
    import { register } from '../utils/index';
    export default {
        name: "job-register",
        data() {
            var checkUserName = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('用户名不能为空'));
                } else {
                    callback();
                }
            };

            var checkTelPhone = (rule, value, callback) => {
                const phoneReg = /^1[3|4|5|7|8][0-9]{9}$/
                if (!value) {
                    return callback(new Error("电话号码不能为空"))
                }
                setTimeout(() => {
                    // Number.isInteger是es6验证数字是否为整数的方法,但是我实际用的时候输入的数字总是识别成字符串
                    // 所以我就在前面加了一个+实现隐式转换

                    if (!Number.isInteger(+value)) {
                        callback(new Error("请输入数字值"))
                    } else {
                        if (phoneReg.test(value)) {
                            callback()
                        } else {
                            callback(new Error("电话号码格式不正确"))
                        }
                    }
                }, 100)
            };

            var checkEmail = (rule, value, callback) => {
                const mailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/
                if (!value) {
                    return callback(new Error("邮箱不能为空"))
                }
                setTimeout(() => {
                    if (mailReg.test(value)) {
                        callback()
                    } else {
                        callback(new Error("请输入正确的邮箱格式"))
                    }
                }, 100)
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
                    buyerEmail: '',
                    resource: '1',
                    telPhone: ''
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
                    telPhone: [
                        { validator: checkTelPhone, trigger: 'blur' }
                    ],
                    buyerEmail: [
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
                        let role;
                        if(this.ruleForm2.resource == '1'){
                            role = 1
                        } else if(this.ruleForm2.resource == '2'){
                            role = 2
                        }
                        register({
                            "username": this.ruleForm2.userName,
                            "email": this.ruleForm2.buyerEmail,
                            "mobile": this.ruleForm2.telPhone,
                            "password": this.ruleForm2.pass,
                            "role": role
                        }).then((res) => {
                            let data = res.data;
                            console.log(`data.code= ${data.code}`)
                            if(data.code == 0){
                                this.$alert("注册成功")
								this.jumpLogin();
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
            // 跳转到登录
            jumpLogin() {
                this.$router.push({
                    path: '/user/login'
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
        justify-content flex-end
        cursor pointer
        font-size 12px
        color rgb(46, 130, 255)

</style>