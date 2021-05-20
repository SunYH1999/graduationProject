<template>
    <div class="PostAddEditor">
        <div class="post-list-title">
            填写岗位信息：
        </div>
        <!--新建岗位、编辑岗位-->
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">

            <el-form-item label="岗位名称" prop="name">
                <el-input v-model="ruleForm.name"></el-input>
            </el-form-item>

            <el-form-item label="岗位分类" prop="category">
                <el-select v-model="ruleForm.category" placeholder="请选择岗位分类">
                    <el-option v-for="item in ruleForm.categoryList" :label="item.name" :value="item.id"></el-option>
                </el-select>
            </el-form-item>

            <el-form-item label="工作经验" prop="workYear">
                <el-input v-model="ruleForm.workYear"></el-input>
            </el-form-item>

            <el-form-item label="薪资" prop="salary">
                <el-input v-model="ruleForm.salary"></el-input>
            </el-form-item>

            <el-form-item label="人数" prop="number">
                <el-input v-model="ruleForm.number"></el-input>
            </el-form-item>

            <el-form-item label="岗位描述" prop="describe">
                <el-input type="textarea" v-model="ruleForm.describe"></el-input>
            </el-form-item>

            <el-form-item label="岗位要求" prop="condition">
                <el-input type="textarea" v-model="ruleForm.condition"></el-input>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
    import { getCompanyDetail, getCategoryList, createJob, editJob } from '../utils/index';
    import { getToken } from '../utils/function';
    export default {
        name: "PostAddEditor",
        data() {
            return {
                ruleForm: {
                    id: '',
                    name: '',
                    category: '',
                    workYear: '',
                    salary: '',
                    number: '',
                    describe: '',
                    condition: '',
                    categoryList: [],
					jobData: 0
                },
                rules: {
                    name: [
                        { required: true, message: '请输入岗位名称', trigger: 'blur' },
                        { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
                    ],
                    category: [
                        { required: true, message: '请选择岗位分类', trigger: 'change' }
                    ],
                    workYear: [
                        { required: true, message: '请输入工作经验(年)', trigger: 'blur' },
                        { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
                    ],
                    salary: [
                        { required: true, message: '请输入薪资（k）', trigger: 'blur' },
                        { min: 1, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
                    ],
                    number: [
                        { required: true, message: '请输入人数', trigger: 'blur' },
                        { min: 1, max: 10, message: '长度在 3 到 10 个字符', trigger: 'blur' }
                    ],
                    describe: [
                        { required: true, message: '请输入岗位描述', trigger: 'blur' },
                        { min: 5, max: 500, message: '长度在 5 到 500 个字符', trigger: 'blur' }
                    ],
                    condition: [
                        { required: true, message: '请输入岗位要求', trigger: 'blur' },
                        { min: 5, max: 500, message: '长度在 3 到 500 个字符', trigger: 'blur' }
                    ]
                }
            };
        },
        methods: {
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        let token = getToken();
                        createJob({
                            token: token,
                            name: this.ruleForm.name,
                            category: this.ruleForm.category,
                            workYear: this.ruleForm.workYear,
                            salary: this.ruleForm.salary,
                            number: this.ruleForm.number,
                            describe: this.ruleForm.describe,
                            condition: this.ruleForm.condition
                        }).then((res) => {
                            let data = res.data
                            console.log(data)
                            if(data.code == 0){
                                this.$alert("创建成功").then(() => {
                                    this.$router.push({
                                        path: '/postlist'
                                    })
									var jobData = jobData + 1
                                })
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
            // 判断当前用户下有没有公司信息，并且公司为已通过状态
            checkCompanyInfo() {
                let token = getToken();

                // 根据token获取公司信息
                getCompanyDetail({
                    token: token
                }).then((res) => {
                    let data = res.data
                    if(data.data == null){
                        this.$alert("您还没有创建公司").then((res) => {
                            this.$router.push({
                                path: '/company'
                            })
                        })
                    }else if(data.data.status == 0){
                        this.$alert("您的公司还在审核中").then((res) => {
                            this.$router.push({
                                path: '/company'
                            })
                        })
                    }else if(data.data.status == 1){
                        this.getCateList()
                    }
                })
            },
            // 获取岗位分类
            getCateList() {
                let token = getToken();

                getCategoryList({
                    token: token,
                    page: 0,
                    pageSize: 100
                }).then((res) => {
                    let data = res.data;
                    this.ruleForm.categoryList = data.dataList
                    console.log(this.ruleForm.categoryList)
                }).catch(() => {

                });
            }
        },
        mounted() {
            this.checkCompanyInfo()
        }
    }
</script>

<style lang="stylus" scoped>
    .PostAddEditor
        width 1200px
        margin 0 auto
        .post-list-title
            border-bottom 2px solid #eee
            padding 20px 0
            margin-bottom 20px
</style>