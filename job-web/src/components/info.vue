<template>
	<div>
		<div v-for="(item, index) in passageList" :key='index'>
			<Passage :title='item.title' :link='item.link'></Passage>
		</div>		
	</div>
</template>

<script>
	import Passage from './passage.vue'
	export default {
		name: 'info',
		components: {
			Passage
		},
		data() {
			return {
				passageList: [
					{
						title: '20届网易云音乐校招题解析',
						link: 'http://www.woshipm.com/zhichang/3937676.html'
					},{
						title: '产品岗位面试技巧',
						link: 'http://www.woshipm.com/zhichang/4192355.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '万字干货：B端面试指引',
						link: 'http://www.woshipm.com/zhichang/4469534.html'
					},{
						title: '互金平台上市，落入“陷阱”',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					},{
						title: '用户运营面试技巧（内附面试题）',
						link: 'http://www.woshipm.com/zhichang/3676126.html'
					}
				]
			}
		}
	}
</script>

<style>
</style>
