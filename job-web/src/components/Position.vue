<template>
	<!--职位列表-->
	<div class="Position">
		<div style="margin: 15px;">
			<el-input placeholder="请输入内容" v-model="input3" class="input-with-select">
				<el-select v-model="select" slot="prepend" placeholder="请选择">
					<el-option label="岗位" value="1"></el-option>
					<el-option label="公司" value="2"></el-option>
				</el-select>
				<el-button slot="append" icon="el-icon-search" @click='search'></el-button>
			</el-input>
		</div>
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
				<el-pagination class="page" @current-change="getHotJobList" layout="prev, pager, next" :page-count="3">
				</el-pagination>

				</el-pagination>
			</div>
		</div>
	</div>
</template>

<script>
	import {
		getJobList
	} from '../utils/index';
	import {
		getToken
	} from '../utils/function';

	export default {
		name: "Position",
		data() {
			return {
				total: '',
				input1: '',
				input2: '',
				input3: '',
				select: '',
				list: [{
					user: {
						company: {

						}
					}
				}]
			}
		},
		methods: {
			search() {
				this.list = [{
						"id": "3d0c8a54fe244cb9b0e78029b0cd1399",
						"name": "前端工程师",
						"workYear": "3年-5",
						"salary": "10-15",
						"number": 10,
						"describe": "1、负责分布式平台上web产品的开发和维护；",
						"condition": "1、具备全栈开发经验，包括网页前端、后端；",
						"updatedAt": "2019-11-27T13:13:49.000Z",
						"user": {
							"id": "810452e9913647fa8a3b41fd579f710e",
							"username": "zhaopinzhe",
							"mobile": "18888888888",
							"email": "zhaopinzhe@qzroc.com",
							"company": {
								"id": "436668e87f5e44a2913c5cc68b62ce8f",
								"name": "QZROC公司",
								"address": "山东省青岛市",
								"capital": 100022,
								"charge": "roc",
								"identification": "000001"
							}
						},
						"category": null
					}, {
						"id": "b08a0cbd36d448f2994aaa26ae21f065",
						"name": "P前端开发工程师",
						"workYear": "3年",
						"salary": "10K",
						"number": 10,
						"describe": "1635465",
						"condition": "465465",
						"updatedAt": "2019-11-23T06:42:10.000Z",
						"user": {
							"id": "810452e9913647fa8a3b41fd579f710e",
							"username": "zhaopinzhe",
							"mobile": "18888888888",
							"email": "zhaopinzhe@qzroc.com",
							"company": {
								"id": "436668e87f5e44a2913c5cc68b62ce8f",
								"name": "QZROC公司",
								"address": "山东省青岛市",
								"capital": 100022,
								"charge": "roc",
								"identification": "000001"
							}
						},
						"category": null
					}, {
						"id": "b08a0cbd36d448f2994aaa26ae21f065",
						"name": "P前端开发工程师",
						"workYear": "3年",
						"salary": "10K",
						"number": 10,
						"describe": "1635465",
						"condition": "465465",
						"updatedAt": "2019-11-23T06:42:10.000Z",
						"user": {
							"id": "810452e9913647fa8a3b41fd579f710e",
							"username": "zhaopinzhe",
							"mobile": "18888888888",
							"email": "zhaopinzhe@qzroc.com",
							"company": {
								"id": "436668e87f5e44a2913c5cc68b62ce8f",
								"name": "QZROC公司",
								"address": "山东省青岛市",
								"capital": 100022,
								"charge": "roc",
								"identification": "000001"
							}
						},
						"category": null
					}, {
						"id": "b08a0cbd36d448f2994aaa26ae21f065",
						"name": "P前端开发工程师",
						"workYear": "3年",
						"salary": "10K",
						"number": 10,
						"describe": "1635465",
						"condition": "465465",
						"updatedAt": "2019-11-23T06:42:10.000Z",
						"user": {
							"id": "810452e9913647fa8a3b41fd579f710e",
							"username": "zhaopinzhe",
							"mobile": "18888888888",
							"email": "zhaopinzhe@qzroc.com",
							"company": {
								"id": "436668e87f5e44a2913c5cc68b62ce8f",
								"name": "QZROC公司",
								"address": "山东省青岛市",
								"capital": 100022,
								"charge": "roc",
								"identification": "000001"
							}
						},
						"category": null
					}]
			},
			//获取岗位列表
			getHotJobList(val) {
				console.log(`当前页: ${val}`);
				let token = getToken();
				getJobList({
					token: token,
					page: val - 1,
					pageSize: 2
				}).then((res) => {
					this.total = +res.data.length
					console.log(11111111, this.total)
					let data = res.data
					console.log(data)
					if (data.code == 0) {
						this.list = data.dataList
						console.log(this.list)
						this.list.map((item) => {
							let data = item.updatedAt;
							console.log(data)
							item.updatedAt = data.replace(/T/, ' ').replace('.000Z', '');
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
	.el-select .el-input {
		width: 130px;
	}

	.input-with-select .el-input-group__prepend {
		background-color: #fff;
	}

	.content-title {
		border-bottom: 2px solid #63d4c7;
		padding-bottom: 10px;
	}



	.item-list {
		width: 100%;
		overflow: hidden;
		background: #fff;
		border-left: solid 1px #f6f6f8;
	}

	.item {
		float: left;
		width: 47.2%;
		display: flex;
		justify-content: space-between;
		padding: 22px 20px;
		border-right: solid 2px #f6f6f8;
		border-bottom: solid 2px #f6f6f8;
		margin-right: -3px;
	}

	.item-left-top-left {
		font-size: 16px;
		font-weight: 400;
		color: #414a60;
	}

	.item-left-top-right {
		color: #fc703e;
		font-size: 16px;
		font-weight: 400;
		padding-left: 8px;
	}

	.item-left-bottom {
		margin-top: 2px;
		font-size: 12px;
		color: #9fa3b0;
	}

	.item-content-top {
		font-size: 16px;
		font-weight: 400;
		color: #414a60;
	}

	.item-content-bottom {
		margin-top: 2px;
		font-size: 12px;
		color: #9fa3b0;
	}

	.item-right-top {
		font-weight: 400;
		font-size: 13px;
		color: #4a4160;
	}

	.item-right-bottom {
		margin-top: 2px;
		font-size: 12px;
		color: #9fa3b0;
	}

	.page {
		margin-top: 20px;
	}
</style>
