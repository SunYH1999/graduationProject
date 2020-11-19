<template>
    <div class="category">
        <div class="category-title">
            分类管理：
        </div>
        <div class="category-title2">
            <el-button
                    type="primary"
                    @click="categoryAdd"
            >添加新分类</el-button>
        </div>
        <div class="category-list">
            <el-table :data="tableData" style="width: 100%">
                <el-table-column label="分类名称" style="width: 60%">
                    <template slot-scope="scope">
                        <div slot="reference" class="name-wrapper">
                            <el-tag size="medium">{{ scope.row.name }}</el-tag>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column label="操作" style="width: 40%">
                    <template slot-scope="scope">
                        <el-button size="mini"
                                @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                        <el-button size="mini" type="danger"
                                @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
    import { getToken } from "../utils/function";
    import { getCategoryList, createCategory, editCategory, deleteCategory } from '../utils/index'

    export default {
        name: "category",
        data() {
            return {
                tableData: []
            }
        },
        methods: {
            // 编辑分类
            handleEdit(index, row) {
                this.$prompt(`需要将“${row.name}”修改为什么呢？`, '提示', {
                    confirmButtonText: '更新',
                    cancelButtonText: '取消',
                }).then(({ value }) => {
                    if(value != null){
                        let token = getToken();
                        editCategory({
                            token: token,
                            name: value,
                            id: row.id
                        }).then((res) => {
                            let data= res.data
                            if(data.code == 0){
                                this.getList()
                            }else{
                                this.$alert(data.errMsg)
                            }
                        })
                    }
                })
            },
            // 删除分类
            handleDelete(index, row) {
                this.$confirm(`确定要将 ${row.name} 分类删除吗`, '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    let token = getToken();
                    deleteCategory({
                        token: token,
                        id: row.id
                    }).then((res) => {
                        let data= res.data
                        if(data.code == 0){
                            this.getList()
                        }else{
                            this.$alert(data.errMsg)
                        }
                    })
                }).catch(() => {

                });
            },
            // 获取分类列表
            getList() {
                let token = getToken();
                getCategoryList({
                    token: token,
                    page: 0,
                    pageSize: 100
                }).then((res) => {
                    let data = res.data;
                    console.log(data)
                    this.tableData = data.dataList
                }).catch(() => {

                });
            },
            // 添加分类
            categoryAdd() {
                this.$prompt('请输入分类名', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                }).then(({ value }) => {
                    if(value != null){
                        let token = getToken();
                        createCategory({
                            token: token,
                            name: value
                        }).then((res) => {
                            let data= res.data
                            if(data.code == 0){
                                this.getList()
                            }else{
                                this.$alert(data.errMsg)
                            }
                        })
                    }
                }).catch(() => {

                });
            }
        },
        mounted() {
            this.getList()
        }
    }
</script>

<style lang="stylus" scoped>
    .category-title
        border-bottom 2px solid #eee
        padding 20px 0
        margin-bottom 40px
    .category-title2
        padding 20px 0
        margin-bottom 20px
</style>