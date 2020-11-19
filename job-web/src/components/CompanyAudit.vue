<template>
    <div class="CompanyAudit">
        <div class="get-company-title">
            审核公司列表：
        </div>
        <div class="company-list" v-if="this.tableData.length == 0">
            当前列表为空
        </div>
        <div class="company-list" v-if="this.tableData.length != 0">
            <div class="company-left" :class="!this.isShow ? 'company-left-flag' : ''">
                <el-table :data="tableData" style="width: 100%">
                    <el-table-column label="公司名" style="width: 20%">
                        <template slot-scope="scope">
                            <el-popover trigger="hover" placement="top">
                                <p>姓名: {{ scope.row.name }}</p>
                                <p>地点: {{ scope.row.address }}</p>
                                <div slot="reference" class="name-wrapper">
                                    <el-tag size="medium">{{ scope.row.name }}</el-tag>
                                </div>
                            </el-popover>
                        </template>
                    </el-table-column>


                    <el-table-column
                            label="法人姓名"
                            style="width: 20%">
                        <template slot-scope="scope">
                            <span style="margin-left: 10px">{{scope.row.charge}}</span>
                        </template>
                    </el-table-column>

                    <el-table-column
                            label="审核状态"
                            style="width: 20%">
                        <template slot-scope="scope">
                            <span style="margin-left: 10px; color:red;" v-if="scope.row.status == 0">未审核</span>
                            <span style="margin-left: 10px" v-if="scope.row.status == 1">已审核</span>
                        </template>
                    </el-table-column>

                    <el-table-column label="操作" style="width: 40%">
                        <template slot-scope="scope">
                            <el-button icon="el-icon-search" circle
                                       @click="showResume(scope.$index, scope.row)"></el-button>
                            <el-button type="success" icon="el-icon-check" circle
                                       @click="successExamine(scope.$index, scope.row)"></el-button>
                            <el-button type="danger" icon="el-icon-delete" circle
                                       @click="errorExamine(scope.$index, scope.row)"></el-button>

                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <div class="company-right" v-if="this.isShow">
                <div class="company-right-top">
                    <el-button type="danger" icon="el-icon-arrow-left" circle @click="hideResume"></el-button>
                </div>
                <div class="company-right-content">
                    <el-form ref="form" :model="resume" label-width="80px">
                        <el-form-item label="公司名">
                            <el-input v-model="resume.name" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="公司地点">
                            <el-input v-model="resume.address" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="注册资金">
                            <el-input v-model="resume.capital" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="法人姓名">
                            <el-input v-model="resume.charge" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="法人身份证">
                            <el-input v-model="resume.identification" disabled></el-input>
                        </el-form-item>
                    </el-form>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import { getToken } from '../utils/function';
    import { getCompanyList, examineCompany } from '../utils/index';
    export default {
        name: "CompanyAudit",
        data() {
            return {
                tableData: [],
                isShow: false,
                resume: {
                    name: '',
                    address: '',
                    capital: '',
                    charge: '',
                    identification: ''
                }
            }
        },
        methods: {
            // 展示当前公司详情
            showResume(index, row) {
                if (!this.isShow) {
                    this.isShow = true;
                }
                this.resume.name = row.name;
                this.resume.address = row.address;
                this.resume.capital = row.capital;
                this.resume.charge = row.charge;
                this.resume.identification = row.identification;

            },
            // 关闭公司详情展示
            hideResume() {
                if (this.isShow) {
                    this.isShow = false;
                }
            },
            // 审核通过
            successExamine(index, row) {
                this.$confirm(`您要通过 ${row.name} 的审核吗`, '提示', {
                    confirmButtonText: '通过审核',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    let token = getToken()
                    examineCompany({
                        token: token,
                        id: row.id,
                        status: 1
                    }).then((res) => {
                        let data = res.data;
                        console.log(data)
                        if(data.code == 0){
                            this.getList()
                            this.$message({
                                type: 'success',
                                message: '已通过!'
                            });
                        }else{
                            this.$alert(data.msg)
                        }
                    })

                }).catch(() => {

                });
            },
            // 审核不通过
            errorExamine(index, row) {
                this.$confirm(`您要拒绝 ${row.name} 的审核吗`, '提示', {
                    confirmButtonText: '拒绝',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    let token = getToken()
                    examineCompany({
                        token: token,
                        id: row.id,
                        status: 0
                    }).then((res) => {
                        let data = res.data;
                        console.log(data)
                        if(data.code == 0){
                            this.getList()
                            this.$message({
                                type: 'success',
                                message: '已拒绝!'
                            });
                        }else{
                            this.$alert(data.msg)
                        }
                    })
                }).catch(() => {

                });
            },
            // 获取审核公司列表
            getList(){
                let token = getToken();
                getCompanyList({
                    token: token,
                    page:0,
                    pageSize: 100
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    this.tableData = data.dataList
                })
            }
        },
        mounted() {
            this.getList()
        }
    }
</script>

<style lang="stylus" scoped>
    .CompanyAudit
        .get-company-title
            border-bottom 2px solid #eee
            padding 20px 0
            margin-bottom 40px
        .company-list
            display flex
            .company-left
                width 740px
                margin-right 20px
                border 1px solid #eee
            .company-left-flag
                width 1440px
            .company-right
                width 700px
                border 1px solid #eee
                .company-right-top
                    padding 10px
                    box-sizing border-box
                    border-bottom 1px solid #eee
                .company-right-content
                    padding 10px
                    box-sizing border-box
</style>