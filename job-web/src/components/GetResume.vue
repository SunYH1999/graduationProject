<template>
    <div class="GetResume">
        <div class="get-resume-title">
            已收到的简历列表：
        </div>
        <!--我收到的简历-->
        <div class="resume-list">
            <div class="resume-left" :class="!this.isShow ? 'resume-left-flag' : ''">
                <el-table :data="tableData" style="width: 100%">
                    <el-table-column label="姓名" style="width: 20%">
                        <template slot-scope="scope">
                            <el-popover trigger="hover" placement="top">
                                <p>姓名: {{ scope.row.name }}</p>
                                <p>期望薪资: {{ scope.row.salary }}</p>
                                <div slot="reference" class="name-wrapper">
                                    <el-tag size="medium">{{ scope.row.name }}</el-tag>
                                </div>
                            </el-popover>
                        </template>
                    </el-table-column>

                    <el-table-column
                            label="应聘岗位"
                            style="width: 20%"
                    >
                        <template slot-scope="scope">
                            <span style="margin-left: 10px">{{scope.row.hope}}</span>
                        </template>
                    </el-table-column>

                    <el-table-column
                            label="工龄"
                            style="width: 20%">
                        <template slot-scope="scope">
                            <span style="margin-left: 10px">{{scope.row.workYear}}</span>
                        </template>
                    </el-table-column>

                    <el-table-column
                            label="手机号码"
                            style="width: 20%">
                        <template slot-scope="scope">
                            <span style="margin-left: 10px">{{scope.row.mobile}}</span>
                        </template>
                    </el-table-column>

                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button size="mini" @click="showResume(scope.$index, scope.row)">查看</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </div>

            <div class="resume-right" v-if="this.isShow">
                <div class="resume-right-top">
                    <el-button type="danger" icon="el-icon-arrow-left" circle @click="hideResume"></el-button>
                </div>
                <div class="resume-right-content">
                    <el-form ref="form" :model="resume" label-width="80px">
                        <el-form-item label="姓名">
                            <el-input v-model="resume.name" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="性别">
                            <el-input v-model="resume.sex" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="出生年月">
                            <el-input v-model="resume.year" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="工作经验">
                            <el-input v-model="resume.workYear" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="现居地">
                            <el-input v-model="resume.address" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="手机号">
                            <el-input v-model="resume.mobile" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="邮箱">
                            <el-input v-model="resume.email" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="求职意向">
                            <el-input v-model="resume.hope" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="期望薪资">
                            <el-input v-model="resume.salary" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="工作经历">
                            <el-input v-model="resume.work" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="教育经历">
                            <el-input v-model="resume.education" disabled></el-input>
                        </el-form-item>
                        <el-form-item label="个人介绍">
                            <el-input v-model="resume.personal" disabled></el-input>
                        </el-form-item>
                    </el-form>
                </div>
            </div>
        </div>


    </div>
</template>

<script>
    import { MygetResume } from '../utils/index';
    import { getToken } from '../utils/function';
    export default {
        name: "GetResume",
        data() {
            return {
                tableData: [],
                isShow: false,
                resume: {
                    name: '孙大鹏',
                    sex: '男',
                    year: '1996.11.4',
                    workYear: '2年',
                    address: '山东青岛',
                    mobile: '17561723745',
                    email: 'sundapeng@haier.com',
                    hope: 'web前端',
                    salary: '8k',
                    work: '那么多那么多',
                    education: '我的教育经历：叭叭叭叭叭叭叭叭叭叭叭叭叭叭',
                    personal: '我的个人介绍：叭叭叭叭叭叭叭叭叭叭叭叭叭叭'
                }
            }
        },
        methods: {
            // 展示当前简历详情
            showResume(index, row) {
                if (!this.isShow) {
                    this.isShow = true;
                }
                this.resume.name = row.name;
                this.resume.sex = row.sex;
                this.resume.year = row.year;
                this.resume.workYear = row.workYear;
                this.resume.address = row.address;
                this.resume.mobile = row.mobile;
                this.resume.email = row.email;
                this.resume.hope = row.hope;
                this.resume.salary = row.salary;
                this.resume.work = row.work;
                this.resume.education = row.education;
                this.resume.personal = row.personal;


            },
            // 关闭简历详情展示
            hideResume() {
                if (this.isShow) {
                    this.isShow = false;
                }
            },
            // 获取我投递的岗位列表
            MygetResume() {
                let token = getToken();
                MygetResume({
                    token
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    this.tableData = data.dataList
                })
            }
        },
        mounted() {
            this.MygetResume()
        }
    }
</script>

<style lang="stylus" scoped>
    .GetResume
        .get-resume-title
            border-bottom 2px solid #eee
            padding 20px 0
            margin-bottom 40px
        .resume-list
            display flex
            .resume-left
                width 740px
                margin-right 20px
                border 1px solid #eee
            .resume-left-flag
                width 1440px
            .resume-right
                width 700px
                border 1px solid #eee
                .resume-right-top
                    padding 10px
                    box-sizing border-box
                    border-bottom 1px solid #eee
                .resume-right-content
                    padding 10px
                    box-sizing border-box
</style>