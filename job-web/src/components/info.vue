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
						title: 'aaa',
						link: 'http://www.woshipm.com/zhichang/3937676.html'
					},{
						title: 'bbb',
						link: 'adsas'
					},{
						title: 'ccc',
						link: 'adsas'
					}
				]
			}
		}
	}
</script>

<style>
</style>
