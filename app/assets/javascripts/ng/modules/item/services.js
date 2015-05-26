'use strict';

(function(){

  var module = angular.module('shoppes.item.services', ['shoppes.api.services' ]);

  module.factory('Item', [ 'Api',
    function(Api){
      // $scope.init = function(){
      //   var params = {
      //     utf8: "✓",
      //     'authenticity_token': $('meta[name=csrf-token]').attr('content'),
      //   }
      //   Api.Item.index(function(data){
      //       $scope.items = data;
      //   }, function(error){
      //       $scope.error = error;
      //   })
      // }
      
      // var items = [];

      var Klass = {
        'items': [],
        'init': function(){
          self = this;
          return Api.Item.index(function(data){
            self.items = data;
          });
        }, 
        'likes': function(){
          self = this;
          return Api.Item.likes(function(data){
            self.items = data;
          });
        },
        'findByCollectionId': function(id){
          console.log("findByCollectionId: " + id);
          // console.log(this.items);
          return _.findIndex(self.items, 'id', id);
        },
        'additem': function(collectionId, itemId, callbackSuccess, callbackFail){
          var params = {
            utf8: "✓",
            'authenticity_token': $('meta[name=csrf-token]').attr('content'),
            'id': collectionId,
            'itemId': itemId, 
          }
          Api.Collection.addItem(params, function(data){
            if (callbackSuccess) {
              callbackSuccess(data);
            }
          }, function(error){
            if (callbackFail) {
              callbackFail(error);
            }
          })
        }
      };

      return Klass;
    } // function
  ]); // module

}());