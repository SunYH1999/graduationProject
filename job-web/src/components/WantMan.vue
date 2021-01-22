<template>
    <div class="wantMan">
		<!-- 轮播图==做广告位 -->
        <Slider />
        <div class="man">
            <div class="list" v-for="item in list" :key="item.id">
                <div class="item">
                    <div class="left">
                        <div class="name">
                            <span class="nickName">{{item.name}}</span>
                            <span class="sex" v-if="item.sex == 1">男</span>
                            <span class="sex" v-if="item.sex != 1">女</span>
                        </div>
                        <div class="bottom">{{item.address}}</div>
                    </div>
                    <div class="content">
                        <div class="name">工龄：{{item.workYear}}</div>
                        <div class="bottom">邮箱：{{item.email}}</div>
                    </div>
                    <div class="right">
                        <div class="name">期望薪资：{{item.salary}}</div>
                        <div class="bottom">已将用户信息保密，可通过邮件联系</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Slider from '@/components/Slider.vue'
    import { MyManResumeList } from '../utils/index';
    import { getToken } from '../utils/function';
    export default {
        name: "want-man",
        components: {
            Slider
        },
        data() {
            return {
                list: []
            }
        },
        methods:{
            // 获取简历列表
            getResumeList() {
                let token = getToken();
                MyManResumeList({
                    token
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    this.list = data.dataList
                })
            }
        },
        mounted() {
            this.getResumeList()
        }
    }
</script>

<style lang="stylus" scoped>
    .list
        border-left solid 2px #f6f6f8
        border-top solid 2px #f6f6f8
    .item
        padding 22px 30px
        display flex
        justify-content space-between
        background white
        border-right solid 2px #f6f6f8
        border-bottom solid 2px #f6f6f8
        margin-right -3px
        .left
            text-align left
            .name
                .nickName
                    font-size 16px
                    font-weight 400
                    max-width 170px
                    display inline-block
                    white-space nowrap
                    overflow hidden
                    text-overflow ellipsis
                    vertical-align middle
                .sex
                    color #fc703e
                    padding-left 8px
        .content
            text-align center
        .right
            text-align right
        .bottom
            margin-top 2px
            font-size 12px
            color #9fa3b0
            width 100%
            overflow hidden
            text-overflow ellipsis
            white-space nowrap
</style>