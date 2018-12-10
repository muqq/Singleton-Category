### Practice
* 熟悉Objective-C`Singleton`以及`Category`的實作
* 熟悉`MediaPlayer`Library的運用

### 心得
* 這次的練習是做一個應用程式可以讀取iPod裡的音樂，並且做一個歌曲列表、歌手列表，和一個可自訂義播放列表，需要使用本地端資料庫。這次練習本地端資練庫使用了第三方套件`Realm`，由於自己也是第一次使用，所以也是先花了些時間研究。
#### 實作時大約主意兩個重點
* 把一直重複用到的地方抽成`Singleton`
* 當`Singleton`太複雜時可以使用`Category`
#### 實作
* 一開始建立`MediaManager`是一個`Singleton`物件，主要負責所有歌曲的操作，所以我幫他分了三個類別`MediaManager+Song`、`MediaManager+Artist`、`MediaManager+PlayList`。每次App開啟在歌曲列表那頁都會同步iPod的資料。歌曲列表和歌手列表目前都只是列出資料，播放清單列表則可以新增、修改及刪除。
