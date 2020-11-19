<template>
    <!--职位列表-->
    <div class="Position">
        <div class="content">
            <div class="content-title">
                热门岗位
            </div>
            <div class="content-list">
                <div class="item-list">
                    <div class="item" @click="jumpJobDetails(item.id)" v-for="item in list" :key="item.id">
                        <div class="item-left">
                            <div class="item-left-top">
                                <span class="item-left-top-left">{{item.name}}</span>
                                <span class="item-left-top-right">{{item.salary}}</span>
                            </div>
                            <div class="item-left-bottom">
                                <span class="item-left-bottom-left">
                                    <span>{{item.user.company.address}}</span> |
                                    <span>{{item.workYear}}</span>
                                </span>
                            </div>
                        </div>
                        <div class="item-content">
                            <div class="item-content-top">
                                {{item.user.company.name}}
                            </div>
                            <div class="item-content-bottom">
                                移动互联网
                            </div>
                        </div>
                        <div class="item-right-top">
                            {{item.user.company.charge}}
                        </div>
                        <div class="item-right-bottom">
                            {{item.updatedAt}}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import {getJobList} from '../utils/index';
    import {getToken} from '../utils/function';

    export default {
        name: "Position",
        data() {
            return {
                list: [
                    {
                        user: {
                            company: {

                            }
                        }
                    }
                ]
            }
        },
        methods: {
            //获取岗位列表
            getHotJobList() {
                let token = getToken();
                getJobList({
                    token: token,
                    page: 0,
                    pageSize: 100
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    if (data.code == 0) {
                        this.list = data.dataList
                        console.log(this.list)
                        this.list.map((item) => {
                            let data = item.updatedAt;
                            console.log(data)
                            item.updatedAt = data.replace(/T/,' ').replace('.000Z','');
                        })
                    } else {
                        this.$alert(data.msg)
                    }
                })
            },
            // 跳转至简历详情页面
            jumpJobDetails(id) {
                this.$router.push({
                    path: '/jobDetails',
                    query: {
                        id
                    }
                })
            }
        },
        mounted() {
            this.getHotJobList()
        }
    }
</script>

<style scoped lang="stylus">
    .content-title
        border-bottom 2px solid #63d4c7
        padding-bottom 10px

    .content-list

        .item-list
            width 100%
            overflow hidden
            background #fff
            border-left: solid 1px #f6f6f8;
            .item
                float: left
                width 47.2%
                display flex
                justify-content space-between
                padding: 22px 20px;
                border-right: solid 2px #f6f6f8;
                border-bottom: solid 2px #f6f6f8;
                margin-right: -3px;
                .item-left-top
                    .item-left-top-left
                        font-size 16px
                        font-weight 400
                        color #414a60
                    .item-left-top-right
                        color #fc703e
                        font-size 16px
                        font-weight 400
                        padding-left 8px
                .item-left-bottom
                    margin-top 2px
                    font-size 12px
                    color #9fa3b0
                .item-content-top
                    font-size: 16px;
                    font-weight: 400;
                    color: #414a60;
                .item-content-bottom
                    margin-top 2px
                    font-size: 12px;
                    color: #9fa3b0;
                .item-right-top
                    font-weight: 400;
                    font-size: 13px;
                    color: #4a4160;
                .item-right-bottom
                    margin-top 2px
                    font-size: 12px;
                    color: #9fa3b0;


</style>