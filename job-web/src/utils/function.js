import router from '../router'
/**
 * 删除localStorage 内容
 */
export const delectUserInfo = function () {
    localStorage.removeItem("recruitUserInfo");
    router.push({
        path: '/user/login'
    })
}

/**
 * 获取UserInfo
 */
export const getUserInfo = function () {
    if(!localStorage.recruitUserInfo){
        router.push({
            path: '/user/login'
        })
    }else {
        let userInfo = JSON.parse(localStorage.recruitUserInfo);
        return userInfo
    }
}


/*
*  获取token
* */
export const getToken = function () {
    if(!localStorage.recruitUserInfo){
        router.push({
            path: '/user/login'
        })
    }else {
        let userInfo = JSON.parse(localStorage.recruitUserInfo);
        if(!userInfo.token){
            router.push({
                path: '/user/login'
            })
        }else{
            let token = userInfo.token
            return token
        }
    }
}