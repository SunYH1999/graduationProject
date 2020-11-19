<template>
    <div class="ResumeEdit">
        <!--编辑我的简历-->
        <div class="page">
            <p class="page-p" v-if="!this.havaMyResume">你还没有填写个人简历，现在要填写吗？</p>
        </div>
        <div class="edit-resume">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">

                <el-form-item label="姓名" prop="name">
                    <el-input v-model="ruleForm.name"></el-input>
                </el-form-item>

                <el-form-item label="性别" prop="sex">
                    <el-radio-group v-model="ruleForm.sex">
                        <el-radio label="男">男</el-radio>
                        <el-radio label="女">女</el-radio>
                    </el-radio-group>
                </el-form-item>

                <el-form-item label="出生年月" prop="year">
                    <el-input v-model="ruleForm.year"></el-input>
                </el-form-item>

                <el-form-item label="工作经验" prop="workYear">
                    <el-input v-model="ruleForm.workYear"></el-input>
                </el-form-item>

                <el-form-item label="现居地" prop="address">
                    <el-input v-model="ruleForm.address"></el-input>
                </el-form-item>

                <el-form-item label="手机号" prop="mobile">
                    <el-input v-model="ruleForm.mobile"></el-input>
                </el-form-item>

                <el-form-item label="邮箱" prop="email">
                    <el-input v-model="ruleForm.email"></el-input>
                </el-form-item>

                <el-form-item label="求职意向" prop="hope">
                    <el-input v-model="ruleForm.hope"></el-input>
                </el-form-item>

                <el-form-item label="期望薪资" prop="salary">
                    <el-input v-model="ruleForm.salary"></el-input>
                </el-form-item>

                <el-form-item label="工作经历" prop="work">
                    <el-input v-model="ruleForm.work"></el-input>
                </el-form-item>

                <el-form-item label="教育经历" prop="education">
                    <el-input v-model="ruleForm.education"></el-input>
                </el-form-item>

                <el-form-item label="个人介绍" prop="personal">
                    <el-input v-model="ruleForm.personal"></el-input>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="submitForm('ruleForm')" v-if="!this.havaMyResume">提交</el-button>
                    <el-button type="primary" @click="updataResume('ruleForm')" v-if="this.havaMyResume">更新</el-button>
                    <el-button @click="resetForm('ruleForm')">重置</el-button>
                </el-form-item>
            </el-form>
        </div>
    </div>
</template>

<script>
    import { getMyResume, createResume, editResume } from '../utils/index';
    import { getToken } from '../utils/function';
    export default {
        name: "ResumeEdit",
        data() {
            return {
                havaMyResume: false,
                ruleForm: {
                    id: '',
                    name: '',
                    sex: '男',
                    year: '',
                    workYear: '',
                    address: '',
                    mobile: '',
                    email: '',
                    hope: '',
                    salary: '',
                    work: '',
                    education: '',
                    personal: ''
                },
                rules: {
                    name: [
                        { required: true, message: '请输入姓名', trigger: 'blur' },
                        { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' }
                    ],
                    sex: [
                        { required: true, message: '请选择性别', trigger: 'change' }
                    ],
                    year: [
                        { required: true, message: '请输入出生年月', trigger: 'blur' },
                        { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
                    ],
                    workYear: [
                        { required: true, message: '请输入工龄', trigger: 'blur' },
                        { min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'blur' }
                    ],
                    address: [
                        { required: true, message: '请输入现居地', trigger: 'blur' },
                        { min: 3, max: 30, message: '长度在 3 到 30 个字符', trigger: 'blur' }
                    ],
                    mobile: [
                        { required: true, message: '请输入手机号', trigger: 'blur' },
                        { min: 11, max: 11, message: '长度为 11 个字符', trigger: 'blur' }
                    ],
                    email: [
                        { required: true, message: '请输入邮箱', trigger: 'blur' },
                        { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
                    ],
                    hope: [
                        { required: true, message: '请输入求职意向', trigger: 'blur' },
                        { min: 2, max: 100, message: '长度在 2 到 100 个字符', trigger: 'blur' }
                    ],
                    salary: [
                        { required: true, message: '请输入期望薪资', trigger: 'blur' },
                        { min: 1, max: 15, message: '长度在 1 到 15 个字符', trigger: 'blur' }
                    ],
                    work: [
                        { required: true, message: '请输入工作经历', trigger: 'blur' },
                        { min: 5, max: 100, message: '长度在 5 到 100 个字符', trigger: 'blur' }
                    ],
                    education: [
                        { required: true, message: '请输入教育经历', trigger: 'blur' },
                        { min: 2, max: 100, message: '长度在 5 到 100 个字符', trigger: 'blur' }
                    ],
                    personal: [
                        { required: true, message: '请输入个人介绍', trigger: 'blur' },
                        { min: 2, max: 200, message: '长度在 5 到 200 个字符', trigger: 'blur' }
                    ]
                }
            };
        },
        methods: {
            // 创建简历
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        let token = getToken();
                        let sex;
                        if(this.ruleForm.sex == "男"){
                            sex = 1
                        }else{
                            sex = 0
                        }

                        createResume({
                            token: token,
                            name: this.ruleForm.name,
                            sex: sex,
                            year: this.ruleForm.year,
                            workYear: this.ruleForm.workYear,
                            address: this.ruleForm.address,
                            mobile: 17863253454,
                            email: this.ruleForm.email,
                            hope: this.ruleForm.hope,
                            salary: 8000,
                            work: this.ruleForm.work,
                            education: this.ruleForm.education,
                            personal: this.ruleForm.personal

                        }).then((res) => {
                            let data = res.data;
                            console.log(data)
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            // 更新简历
            updataResume(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        let token = getToken();
                        let sex;
                        if(this.ruleForm.sex == "男"){
                            sex = 1
                        }else{
                            sex = 0
                        }

                        editResume({
                            token: token,
                            id: this.ruleForm.id,
                            name: this.ruleForm.name,
                            sex,
                            year: this.ruleForm.year,
                            workYear: this.ruleForm.workYear,
                            address: this.ruleForm.address,
                            mobile: 17863253454,
                            email: this.ruleForm.email,
                            hope: this.ruleForm.hope,
                            salary: 8000,
                            work: this.ruleForm.work,
                            education: this.ruleForm.education,
                            personal: this.ruleForm.personal
                        }).then((res) => {
                            let data = res.data;
                            console.log(data)
                            if(data.code == 0){
                                this.$alert("填写简历成功")
                            }else{
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
            // 读取个人简历
            getMyResume() {
                let token = getToken();

                // 根据token获取自己简历
                getMyResume({
                    token: token
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    // 判断是否没有添加简历
                    if(data.data == null) {
                        console.log("我没有简历")
                        this.havaMyResume = false;
                    }else {
                        console.log("我有简历")
                        this.havaMyResume = true;
                        this.ruleForm.id = data.data.id;
                        this.ruleForm.name = data.data.name;

                        this.ruleForm.year = data.data.year;
                        this.ruleForm.workYear = data.data.workYear;
                        this.ruleForm.address = data.data.address;
                        this.ruleForm.mobile = data.data.mobile;
                        this.ruleForm.email = data.data.email;
                        this.ruleForm.hope = data.data.hope;
                        this.ruleForm.salary = data.data.salary;
                        this.ruleForm.work = data.data.work;
                        this.ruleForm.education = data.data.education;
                        this.ruleForm.personal = data.data.personal;

                        if(data.data.sex == 1){
                            this.ruleForm.sex = "男"
                        }else{
                            this.ruleForm.sex = "女"
                        }

                    }
                })
            }
        },
        mounted() {
            // 获取个人简历信息
            this.getMyResume()
        }
    }
</script>

<style scoped>

</style>