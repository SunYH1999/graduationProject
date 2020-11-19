<template>
    <div class="MeSendPost">
        <!--已投递的岗位列表-->
        <div class="send-post-title">
            已投递的岗位列表:
        </div>
        <el-table :data="tableData" style="width: 100%">
            <el-table-column label="公司名称" width="300">
                <template slot-scope="scope">
                    <el-popover trigger="hover" placement="top">
                        <p>岗位名称: {{ scope.row.name }}</p>
                        <p>薪资待遇: {{ scope.row.salary }}</p>
                        <div slot="reference" class="name-wrapper">
                            <el-tag size="medium">{{ scope.row.user.company.name }}</el-tag>
                        </div>
                    </el-popover>
                </template>
            </el-table-column>

            <el-table-column
                    label="公司地址"
                    width="300">
                <template slot-scope="scope">
                    <span style="margin-left: 10px">{{scope.row.user.company.address}}</span>
                </template>
            </el-table-column>

            <el-table-column
                    label="工龄要求"
                    width="300">
                <template slot-scope="scope">
                    <span style="margin-left: 10px">{{scope.row.workYear}}</span>
                </template>
            </el-table-column>

            <el-table-column
                    label="所需人数"
                    width="300">
                <template slot-scope="scope">
                    <span style="margin-left: 10px">{{scope.row.number}}</span>
                </template>
            </el-table-column>

        </el-table>
    </div>
</template>

<script>
    import { getMyJob } from '../utils/index';
    import { getToken } from '../utils/function';
    export default {
        name: "MeSendPost",
        data() {
            return {
                tableData: []
            }
        },
        methods: {
            handleEdit(index, row) {
                console.log(index, row);
            },
            handleDelete(index, row) {
                console.log(index, row);
            },
            // 获取我投递的岗位列表
            getMyPostDetail() {
                let token = getToken();
                getMyJob({
                    token
                }).then((res) => {
                    let data = res.data
                    console.log(data)
                    this.tableData = data.dataList
                })
            }
        },
        mounted() {
            this.getMyPostDetail()
        }
    }
</script>

<style lang="stylus" scoped>
    .MeSendPost
        width 1200px
        margin 0 auto
        .send-post-title
            border-bottom 2px solid #eee
            padding 20px 0
</style>