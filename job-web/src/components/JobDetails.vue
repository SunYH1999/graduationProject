<template>
    <div id="JobDetails">
        <div class="JobDetails">
            <div class="top">
                <div class="top-left">
                    <div class="job">
                        <span class="job-name">{{info.name}}</span>
                        <span class="job-money">{{info.salary}}</span>
                    </div>
                    <div class="job-require">
                        <span>城市：{{info.address}}</span> |
                        <span>工作经验：{{info.workYear}}</span> |
                        <span>学历：本科</span>
                    </div>
                    <!--<div class="job-label">-->
                        <!--<span class="job-label-span">java</span>-->
                        <!--<span class="job-label-span">后端开发</span>-->
                    <!--</div>-->
                </div>
                <div class="top-right">
                    <div class="company-name">
                        {{info.company}}
                    </div>
                    <div class="company-info">
                        <span>已上市</span> |
                        <span>{{info.number}}人</span> |
                        <span>{{info.category}}</span>
                    </div>
                </div>
            </div>

        </div>
        <div class="JobDesc">
            <div class="content">
                <div class="job-description">
                    <div class="title">职位描述</div>
                    <div class="description">
                        {{info.describe}}
                    </div>
                </div>
                <div class="job-requirements">
                    <div class="title">职位要求</div>
                    <div class="requirements">
                        {{info.condition}}
                    </div>
                </div>
            </div>
        </div>
        <div class="submitResume">
            <div class="button" @click="checkMyResume">发送简历</div>
        </div>
    </div>
</template>

<script>
    import { getMyResume, deliveryJob, getJobDetail } from '../utils/index';
    import { getToken } from '../utils/function';
    export default {
        name: "job-details",
        data() {
            return {
                info: {
                    name: '123',
                    salary: '',
                    workYear: '',
                    number: '',
                    condition: '',
                    describe: '',
                    address: '',
                    category: '',
                    company: '',
					resumeData: 0
                }

            }
        },
        methods:{
            // 获取当前简历详情
            getNowJobDetail(id){
                let token = getToken();
                getJobDetail({
                    token,
                    id
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    console.log(this.info)
                    this.info.name = data.data.name;
                    this.info.salary = data.data.salary;
                    this.info.workYear = data.data.workYear;
                    this.info.number = data.data.number;
                    this.info.condition = data.data.condition;
                    this.info.describe = data.data.describe;
                    this.info.address = data.data.user.company.address;
                    this.info.category = data.data.category.name;
                    this.info.company = data.data.user.company.name;
                })
            },
            // 投递简历
            submitResume(resumeId) {
                let token = getToken();
                let jobId = this.$route.query.id
                let resId = resumeId
				var resumeData = resumeData+1
                deliveryJob({
                    token,
                    jobId,
                    resumeId: resId
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    if(data.code == 0){
                        this.$alert("投递成功")
                    }
                })
				
            },
			
            // 检查我是否已添加简历
            checkMyResume() {
                let token = getToken();
                getMyResume({
                    token
                }).then((res) => {
                    let data = res.data
                    if(data.data == null){
                        this.$alert("我没有简历").then(() => {
                            this.$router.push({
                                path: '/resumeedit'
                            })
                        })
                    }else{
                        let resumeId = data.data.id;
                        console.log(`resumeId = ${resumeId}`)
                        this.submitResume(resumeId)
                    }
                })
            }
        },
        mounted() {
            let id = this.$route.query.id
            this.getNowJobDetail(id)
        }
    }
</script>

<style lang="stylus" scoped>
    #JobDetails
        width 1440px
        .JobDetails
            width 1440px
            background #424A61
        .top
            margin 0 auto
            width 1000px
            padding 15px 0
            color white
            display flex
            justify-content space-between
            .top-left
                .job
                    padding: 5px 0 8px;
                    .job-name
                        font-size: 24px;
                        font-weight: 400;
                        margin-right: 10px;
                        line-height: 35px;
                    .job-money
                        font-size: 14px;
                        background: #fa6a43;
                        color: #fff;
                        line-height: 22px;
                        padding: 0 11px;
                        border-radius: 15px;
                .job-require
                    line-height: 26px;
                    font-size: 14px;
                .job-label
                    padding-top: 8px;
                    .job-label-span
                        display: inline-block;
                        border: 1px #d1d4da solid;
                        padding: 0 12px;
                        line-height: 20px;
                        border-radius: 15px;
                        margin-right: 15px;
                        margin-top: 6px;
                        font-size: 12px;
                        color: #9fa3af;
                        margin-bottom: 10px;
            .top-right
                .company-name
                    font-size: 24px;
                    color: #fff;
                    font-weight: 400;
                    padding: 5px 0 8px;
                    text-align right;
                .company-info
                    line-height: 26px;
                    font-size: 14px;


        .JobDesc
            width 1000px
            margin 15px auto
            .job-description
                .title
                    font-weight: 700;
                    font-size: 17px;
                    color: #424a5e;
                    padding-bottom 5px
                    border-bottom  3px solid #6ADBCF
                .description
                    color: #61687c;
                    line-height: 36px;
                    font-size: 15px;
            .job-requirements
                margin-top 20px
                .title
                    font-weight: 700;
                    font-size: 17px;
                    color: #424a5e;
                    padding-bottom 5px
                    border-bottom  3px solid #6ADBCF
                .requirements
                    color: #61687c;
                    line-height: 36px;
                    font-size: 15px;
        .submitResume
            width 1440px
            height 100px
            background #424A61
            color white
            text-align right
            font-size 18px
            .button
                text-align center
                display inline-block
                width 150px
                height 50px
                line-height 50px
                background #6ADBCF
                position relative
                top 25px
                right 80px
                cursor pointer
                border-radius 5px
</style>