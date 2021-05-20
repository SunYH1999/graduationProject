<template>
	<div style="padding: 50px;">
		<div class="block">
			<span class="demonstration">公司真实性</span>
			<el-rate v-model="value1" :colors="colors">
			</el-rate>
		</div>

		<div class="block">
			<span class="demonstration">岗位真实性</span>
			<el-rate v-model="value2" :colors="colors">
			</el-rate>
		</div>

		<div class="block">
			<span class="demonstration">面试体验</span>
			<el-rate v-model="value3" :colors="colors">
			</el-rate>
		</div>

		<div class="block">
			<span class="demonstration">处理速度</span>
			<el-rate v-model="value4" :colors="colors">
			</el-rate>
		</div>

		<div class="block">
			<span class="demonstration">公司推荐</span>
			<el-rate v-model="value5" :colors="colors">
			</el-rate>
		</div>
		<div style="width: 70%;">
			请提出您宝贵的意见或建议
			<el-input type="textarea" :rows="4" placeholder="请输入内容" v-model="textarea">
			</el-input>
		</div>
		<el-button type="success" @click='success'>提交</el-button>


	</div>
</template>

<script>
	import { createEvaluate } from '../utils/index';
	import { getToken } from '../utils/function';
	export default {
		data() {
			return {
				textarea: '',
				value1: null,
				value2: null,
				value3: null,
				value4: null,
				value5: null,
				colors: ['#99A9BF', '#F7BA2A', '#FF9900'] // 等同于 { 2: '#99A9BF', 4: { value: '#F7BA2A', excluded: true }, 5: '#FF9900' }
			}
		},
		methods: {
			success() {
				let token = getToken();
				console.log(token)
				console.log(11111,this.value2)
				this.$alert("提交成功").then(() => {
				    this.$router.replace({
				        path: '/mesendpost'
				    })
				})
				createEvaluate({
					token: token,
				    companyname: '健康科技有限公司',
				    value1: this.value1,
				    value2: this.value2,
				    value3: this.value3,
					value4: this.value4,
					value5: this.value5,
				    text: this.textarea	
				}).then((res) => {
				    let data = res.data;
					console.log('aaaa')
				    console.log(`data.code= ${data.code}`)
					console.log('bbbb')
				    if(data.code == 0){
				        this.$alert("提交成功").then(() => {
				            this.$router.replace({
				                path: '/mesendpost'
				            })
				        })
				    }else if(data.code == 1){
				        this.$alert(data.errMsg)
				    }
				})
				
				
				// this.$alert("提交成功").then(() => {
				//     this.$router.replace({
				//         path: '/mesendpost'
				//     })
				// })
			}
		}
	}
</script>

<style>
</style>
