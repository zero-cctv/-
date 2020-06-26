<template>
  <view>
    <cmd-nav-bar back title="信息设置"></cmd-nav-bar>
    <cmd-page-body type="top">
      <cmd-transition name="fade-up">
        <view>
          <cmd-cel-item title="头像" slot-right arrow>
            <cmd-avatar :src="icon"></cmd-avatar>
          </cmd-cel-item>
          <cmd-cel-item title="积分" :addon="score" arrow></cmd-cel-item>
          <cmd-cel-item title="昵称" :addon="name" arrow></cmd-cel-item>
          <cmd-cel-item title="姓名" :addon="username" arrow></cmd-cel-item>
          <cmd-cel-item title="联系方式" :addon="phone" arrow></cmd-cel-item>
          <cmd-cel-item title="证件号码" :addon="persionid" arrow></cmd-cel-item>
          <cmd-cel-item title="我的地址" :addon="address" arrow></cmd-cel-item>
          <cmd-cel-item title="修改密码" @click="fnClick('modify')" arrow></cmd-cel-item>
          <button class="btn-logout">退出登录</button>
        </view>
      </cmd-transition>
    </cmd-page-body>
  </view>
</template>

<script>
  import cmdNavBar from "@/components/cmd-nav-bar/cmd-nav-bar.vue"
  import cmdPageBody from "@/components/cmd-page-body/cmd-page-body.vue"
  import cmdTransition from "@/components/cmd-transition/cmd-transition.vue"
  import cmdCelItem from "@/components/cmd-cell-item/cmd-cell-item.vue"
  import cmdAvatar from "@/components/cmd-avatar/cmd-avatar.vue"

  export default {
    components: {
      cmdNavBar,
      cmdPageBody,
      cmdTransition,
      cmdCelItem,
      cmdAvatar
    },

    data() {
      return {
		  icon:'',
		  score:'',
		  name:'',
		  username:'',
		  phone:'',
		  persionid:'',
		  address:'',
		  uid:'',
		  data:''
	  };
    },

	onShow() {
		this.uid= this.$getStorage("uid");
		var p={'uid':this.uid};
		var url=this.$api.user.info;
		this.getData(url,'userinfo',p)
	},
    mounted() {},
    onLoad() {
    	// var p={'uid':this.uid};
    	// var url=this.$api.user.getUser;
    	// getData(url,'userinfo',p)
    },
	onPullDownRefresh() {
		setTimeout(function () {
		        uni.stopPullDownRefresh();  //停止下拉刷新动画
		    }, 1000);
		},
    methods:{

	  getData(surl, str,p) {
	  		uni.request({
	  			url: surl,
	  			method: 'GET',
	  			data: p,
	  			success: res => {
	  				console.log('发送网址:' + surl);
	  				this.data = res;
	  				
	  			},
	  			fail: () => {
	  				console.log('this is fail');
	  			},
	  			complete: () => {
	  				this.requestafter(str);
	  			}
	  		});
	  	
	  },
	  requestafter(str) {
		  console.log(this.data);
		  if(str=='userinfo'){
			  if(this.data!=''){
				  this.score=this.data.data.score;
				  this.name=this.data.data.name;
				  this.username=this.data.data.username;
				  this.phone=this.data.data.phone;
				  this.persionid=this.data.data.identity;
				  this.address=this.data.data.addressID;
				  this.icon=this.data.data.icourl;
				  // console.log("url:=="+this.data.data.icourl)
			  }
		  }
		  
		  },
	  /**
	   * 点击触发
	   * @param {Object} type 跳转页面名或者类型方式
	   */
      fnClick(type){
        if(type == 'modify'){
          uni.navigateTo({
            url:'/pages/user/modify/modify'
          })
        }
      }
    }
  }
</script>

<style>
	page,view{
		display: block;
	}
		@import url("../../common/uni/uni.css");
  .btn-logout {
    margin-top: 100upx;
    width: 80%;
    border-radius: 50upx;
    font-size: 16px;
    color: #fff;
    background: linear-gradient(to right, #365fff, #36bbff);
  }

  .btn-logout-hover {
    background: linear-gradient(to right, #365fdd, #36bbfa);
  }
</style>
