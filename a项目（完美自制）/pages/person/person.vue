<template>
  <view>
    <view class="person-head">
      <cmd-avatar :src="icon" @click="fnInfoWin" size="lg" :make="{'background-color': '#fff'}"></cmd-avatar>
      <view class="person-head-box">
        <view class="person-head-nickname" v-text="username"></view>
        <view class="person-head-username" v-text="userID"></view>
      </view>
    </view>
    <view class="person-list">
      <cmd-cell-item title="我的设备" slot-left arrow>
        <cmd-icon type="bullet-list" size="24" color="#368dff"></cmd-icon>
      </cmd-cell-item>
      <cmd-cell-item title="消息通知" slot-left arrow>
        <cmd-icon type="message" size="24" color="#368dff"></cmd-icon>
      </cmd-cell-item>
      <cmd-cell-item title="系统设置" slot-left arrow>
        <cmd-icon type="settings" size="24" color="#368dff"></cmd-icon>
      </cmd-cell-item>
  
	  <cmd-cell-item title="其他网站" addon="试试" slot-left arrow v-on:click="chang">
	    <cmd-icon type="alert-circle" size="24" color="#368dff"></cmd-icon>
	  </cmd-cell-item>
    </view>
  </view>
</template>

<script>

  import cmdAvatar from "@/components/cmd-avatar/cmd-avatar.vue"
  import cmdIcon from "@/components/cmd-icon/cmd-icon.vue"
  import cmdCellItem from "@/components/cmd-cell-item/cmd-cell-item.vue"
	var __self;
	
  export default {
    components: {
      cmdAvatar,
      cmdCellItem,
      cmdIcon
    },
    data() {
      return {
		  username:"",
		  userID:"",
		  uid:"",
		  data:"",
		  icon:""
	  };
    },
	onShow:function() {
		
			 uni.startPullDownRefresh({});
		/*从本地缓存中获取uid*/		            			
						// __self.uid=__self.$getStorage("uid").toString();
						// __self.userID="uid:"+__self.uid.substr(0,5);
						// __self.username=__self.$getStorage("username");
						// __self.icon=__self.$getStorage("icon");

		      //            uni.removeStorage({key: 'uid'});
						  // uni.removeStorage({key: 'username'});
		      
	},
	onLoad:function(){
		__self=this;
	},	
	onPullDownRefresh() {
	       //监听下拉刷新动作的执行方法，每次手动下拉刷新都会执行一次
	       console.log('refresh');
		   __self.uid=__self.$getStorage("uid").toString();
		   __self.userID="uid:"+__self.uid.substr(0,5);
		   __self.username=__self.$getStorage("username");
		   __self.icon=__self.$getStorage("icon");
	       setTimeout(function () {
	           uni.stopPullDownRefresh();  //停止下拉刷新动画
	       }, 500);
	   },
    methods: {
		sendGurl(surl, str,p) {
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
		sendPurl(curl, str, p) {
			uni.request({
				url: curl,
				method: 'POST',
				data: p,
				header:{"Content-Type":"application/x-www-form-urlencoded"}, 				
				success: res => {
					console.log('发送网址:' + curl);
					console.log('send:' + p);
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
			if(str=='getUser'){
				uni.showToast({
				    icon: 'none',
					position: 'bottom',
				    title: '获取成功'
				});
				this.username=this.data.data.username;
				let str=this.data.data.uid;
				str=str.toString().substr(0,5);
				this.userID=str;
				
			}
		},
		
		/*获取用户信息*/
		getUser(){
			console.log(this.uid);
			if(this.uid){
				var url=this.$api.user.info;
				var p={'uid':this.uid}
				this.sendGurl(url,'getUser',p);
			}
		},

      /* 打开用户信息页*/	  
	  chang(){
		  __self.username="大水",
		 uni.navigateTo({
		   url:  '../about/about'
		 }) 
	  },
      fnInfoWin() {
		
        uni.navigateTo({
          url: '/pages/user/info/info'
        })
      }
    }
  }
</script>

<style>
	page,view{
		display: block;
	}
		@import url("../../common/uni/uni.css");
  .person-head {
    display: flex;
    flex-direction: row;
    align-items: center;
    height: 150px;
    padding-left: 20px;
    background: linear-gradient(to right, #365fff, #36bbff);
  }

  .person-head-box {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    margin-left: 10px;
  }

  .person-head-nickname {
    font-size: 18px;
    font-weight: 500;
    color: #fff;
  }

  .person-head-username {
    font-size: 14px;
    font-weight: 500;
    color: #fff;
  }

  .person-list {
    line-height: 0;
  }
</style>
