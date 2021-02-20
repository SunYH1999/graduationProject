<template>
    <div class="post-list">
        <!--已发布岗位列表-->
        <div class="post-list-title">
            已发布岗位列表：
        </div>
		
        <el-table :data="tableData" style="width: 100%">
            <el-table-column label="姓名" width="220">
                <template slot-scope="scope">
                    <el-popover trigger="hover" placement="top">
                        <p>岗位名称: {{ scope.row.name }}</p>
                        <p>薪资待遇: {{ scope.row.salary }}</p>
                        <div slot="reference" class="name-wrapper">
                            <el-tag size="medium">{{ scope.row.name }}</el-tag>
                        </div>
                    </el-popover>
                </template>
            </el-table-column>

            <el-table-column
                    label="薪资"
                    width="220">
                <template slot-scope="scope">
                    <span style="margin-left: 10px">{{scope.row.salary}}</span>
                </template>
            </el-table-column>

            <el-table-column
                    label="工龄要求"
                    width="220">
                <template slot-scope="scope">
                    <span style="margin-left: 10px">{{scope.row.workYear}}</span>
                </template>
            </el-table-column>

            <el-table-column
                    label="所需人数"
                    width="220">
                <template slot-scope="scope">
                    <span style="margin-left: 10px">{{scope.row.number}}</span>
                </template>
            </el-table-column>

            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                    <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>


        <el-dialog title="岗位修改" :visible.sync="dialogFormVisible">
            <el-form :model="form">
                <el-form-item label="岗位名称" :label-width="formLabelWidth">
                    <el-input v-model="form.name" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="岗位分类" :label-width="formLabelWidth">
                    <el-select v-model="form.region" placeholder="请选择岗位分类">
                        <el-option v-for="item in form.categoryList" :label="item.name" :value="item.id"></el-option>
                    </el-select>
                </el-form-item>

                <el-form-item label="工龄" :label-width="formLabelWidth">
                    <el-input v-model="form.workYear" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="薪资" :label-width="formLabelWidth">
                    <el-input v-model="form.salary" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="需求人数" :label-width="formLabelWidth">
                    <el-input v-model="form.number" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="岗位描述" :label-width="formLabelWidth">
                    <el-input v-model="form.describe" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item label="岗位要求" :label-width="formLabelWidth">
                    <el-input v-model="form.condition" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="editCompanyJob">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import { getCompanyDetail, getMyJobList, getCategoryList, editJob } from '../utils/index';
    import { getToken } from '../utils/function';
    export default {
        name: "PostList",
        data() {
            return {
                tableData: [],
                dialogFormVisible: false,
                form: {
                    id: '',
                    name: '',
                    categoryId: '',
                    workYear: '',
                    salary: '',
                    number: 0,
                    describe: "",
                    condition: "",
                    region: "",
                    categoryList: []
                },
                formLabelWidth: '120px'
            }
        },
        methods: {
            handleEdit(index, row) {
                console.log(index, row);
                this.getCateList()
                this.form.id = row.id;
                this.form.name = row.name;
                this.form.workYear = row.workYear;
                this.form.salary = row.salary;
                this.form.number = row.number;
                this.form.describe = row.describe;
                this.form.condition = row.condition;

                this.dialogFormVisible = true
            },
            handleDelete(index, row) {
                console.log(index, row);
            },
            // 判断当前用户下有没有公司信息，并且公司为已通过状态
            checkCompanyInfo() {
                let token = getToken();

                // 根据token获取公司信息
                getCompanyDetail({
                    token: token
                }).then((res) => {
                    let data = res.data
                    console.log(data)
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
                        this.getCompanyJobList()
                    }
                })
            },
            // 获取岗位列表
            getCompanyJobList() {
                let token = getToken();
                getMyJobList({
                    token: token
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    if(data.code == 0){
                        this.tableData = data.dataList
                    }else{
                        this.$alert(data.errMsg)
                    }
                })
            },
            // 获取岗位分类
            getCateList() {
                let token = getToken();
                console.log("进入了这个方法")
                getCategoryList({
                    token: token,
                    page: 0,
                    pageSize: 100
                }).then((res) => {
                    let data = res.data;
                    console.log(data)
                    this.form.categoryList = data.dataList
                    console.log(data.dataList[0].id)
                    this.form.region = data.dataList[0].name
                }).catch(() => {

                });
            },
            // 编辑岗位
            editCompanyJob() {
                let token = getToken();

                editJob({
                    token: token,
                    id: this.form.id,
                    name: this.form.name,
                    category: this.form.category,
                    workYear: this.form.workYear,
                    salary: this.form.salary,
                    number: this.form.number,
                    describe: this.form.describe,
                    condition: this.form.condition
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    if(data.code == 0){
                        this.$alert("岗位信息已更新");
                        this.getCompanyJobList()
                        this.dialogFormVisible = false
                    }else{
                        this.$alert(data.errMsg)
                    }
                })
            }
        },
        mounted() {
            this.checkCompanyInfo()
        }
    }
</script>

<style lang="stylus" scoped>
    .post-list
        width 1200px
        margin 0 auto
        .post-list-title
            border-bottom 2px solid #eee
            padding 20px 0
</style>