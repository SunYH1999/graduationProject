<template>
    <div class="Company">
        <div class="page">
            <p class="page-p" v-if="!this.havaCompany">你还没有填写公司信息，现在要填写吗？</p>
        </div>
        <div class="company-block">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">

                <el-form-item label="公司名" prop="name">
                    <el-input v-model="ruleForm.name"></el-input>
                </el-form-item>

                <el-form-item label="公司地点" prop="address">
                    <el-input v-model="ruleForm.address"></el-input>
                </el-form-item>

                <el-form-item label="注册资金" prop="capital">
                    <el-input type="number" v-model.number="ruleForm.capital" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="法人姓名" prop="charge">
                    <el-input v-model="ruleForm.charge"></el-input>
                </el-form-item>

                <el-form-item label="法人身份证" prop="identification">
                    <el-input v-model="ruleForm.identification"></el-input>
                </el-form-item>

                <el-form-item>

                    <el-button
                            v-if="this.ruleForm.status == 99"
                            type="primary"
                            @click="submitForm('ruleForm')"
                    >
                        提交审核
                    </el-button>

                    <el-button
                            v-if="this.ruleForm.status == 0"
                            type="primary"
                            @click="examineing('ruleForm')"
                    >
                        审核中
                    </el-button>

                    <el-button
                            v-if="this.ruleForm.status == 1"
                            type="primary"
                            @click="updataFrom('ruleForm')"
                    >
                        更新公司资料
                    </el-button>

                    <el-button @click="resetForm('ruleForm')">重置</el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>
</template>

<script>
    import { getCompanyDetail, createCompany, editCompany } from '../utils/index';
    import { getToken } from '../utils/function';
    export default {
        name: "company",
        data() {
            return {
                ruleForm: {
                    id: '',
                    name: '',
                    address: '',
                    capital: '',
                    charge: '',
                    identification: '',
                    status: 99
                },
                rules: {
                    name: [
                        { required: true, message: '请输入公司名', trigger: 'blur' },
                        { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
                    ],
                    address: [
                        { required: true, message: '请输入公司地点', trigger: 'blur' },
                        { min: 3, max: 30, message: '长度在 3 到 20 个字符', trigger: 'blur' }
                    ],
                    capital: [
                        { required: true, message: '年龄不能为空'},
                        { type: 'number', message: '年龄必须为数字值'}
                    ],
                    charge: [
                        { required: true, message: '请输入法人姓名', trigger: 'blur' },
                        { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'blur' }
                    ],
                    identification: [
                        { required: true, message: '请输入法人身份证', trigger: 'blur' },
                        { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
                    ],
                },
                havaCompany: false
            };
        },
        methods: {
            // 提交表单
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        let token = getToken()
                        createCompany({
                            token: token,
                            name: this.ruleForm.name,
                            address: this.ruleForm.address,
                            capital: this.ruleForm.capital,
                            charge: this.ruleForm.charge,
                            identification: this.ruleForm.identification
                        }).then((res) => {
                            let data = res.data
                            console.log(data)
                            if(data.code == 0){
                                this.getCompanyInfo()
                                this.$message({
                                    type: 'success',
                                    message: '已提交，等待管理员审核!'
                                });
                            }else{
                                this.$alert(data.msg)
                            }
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            // 表单审核中
            examineing() {
                this.$alert("您的公司信息还在审核中，请耐心等待")
            },
            // 更新资料
            updataFrom(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        let token = getToken()
                        editCompany({
                            token: token,
                            id: this.ruleForm.id,
                            name: this.ruleForm.name,
                            address: this.ruleForm.address,
                            capital: this.ruleForm.capital,
                            charge: this.ruleForm.charge,
                            identification: this.ruleForm.identification
                        }).then((res) => {
                            let data = res.data
                            console.log(data)
                            if (data.code == 0) {
                                this.getCompanyInfo()
                                this.$message({
                                    type: 'success',
                                    message: '已更新!'
                                });
                            } else {
                                this.$alert(data.msg)
                            }
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            // 重置表单
            resetForm(formName) {
                this.$refs[formName].resetFields();
            },
            // 获取公司信息
            getCompanyInfo() {
                let token = getToken();

                // 根据token获取公司信息
                getCompanyDetail({
                    token: token
                }).then((res) => {
                    let data = res.data
                    console.log(data)

                    if(data.data == null) {
                        this.havaCompany = false
                    }else {
                        this.havaCompany = true;
                        this.ruleForm.id = data.data.id
                        this.ruleForm.name = data.data.name
                        this.ruleForm.address = data.data.address
                        this.ruleForm.capital = data.data.capital
                        this.ruleForm.charge = data.data.charge
                        this.ruleForm.identification = data.data.identification
                        this.ruleForm.status = data.data.status
                    }
                })
            }
        },
        mounted() {
            // 获取公司信息
            this.getCompanyInfo()
        }
    }
</script>

<style lang="stylus" scoped>
    .page
        margin 30px 0
        text-align center
        .page-botton
            padding-top 20px
</style>