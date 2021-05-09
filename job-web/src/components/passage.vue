<template>
	<div class="passage" @click="jump">
		<h1 class="title">
			{{title}}
		</h1>
		<hr>
	</div>
</template>

<script>
	export default {
		name: 'passage',
		props: {
			title: String,
			link: String
		},
		methods: {
			jump() {
				window.open(this.link,'_blank') // 在新窗口打开外链接
				// window.location.href =this.indexro;  //在本页面打开外部链接
			}
		}
	}
</script>

<style scoped>
	* {
		margin: 0;
		padding: 0;
	}
	html, body {
		width: 100%;
		height: 100%;
	}
	.passage {
		width: 90%;
		height: 50px;
		margin: 20px auto;
		/* background-color: rgba(222, 45, 45,.4); */
	}
	.title {
		font-size: ;
	}
</style>
