'use strict';

(function(){

  var module = angular.module('shoppes.collection.services', ['shoppes.api.services' ]);

  module.factory('Collection', [ 'Api',
    function(Api){

      // One time fetch all the user collection
      var collections = Api.Collection.index();

      var collection = {
        'collections': collections,
        'index': function(){
          Api.Collection.index(function(data){
            // collections = data;
          })
        }, 
        'create': function(name, callbackSuccess, callbackFail){

          // utf8:✓
          // authenticity_token:v0ppH+de13QUg8ZLenD6I1DN7yDwCO1Ov+BPnX8fs6U=
          // collection[name]:ffff
          // collection[description]:ffff
          // commit:Create Collection
          // utf8=%E2%9C%93&authenticity_token=v0ppH%2Bde13QUg8ZLenD6I1DN7yDwCO1Ov%2BBPnX8fs6U%3D&collection%5Bname%5D=gt&collection%5Bdescription%5D=&commit=Create+Collection

          var params = {
            utf8: "✓",
            'authenticity_token': $('meta[name=csrf-token]').attr('content'),
            'collection': { name: name },
            'commit': 'Create Collection'
          }

          Api.Collection.create(params, function(data){
            // console.log(data);
            if (callbackSuccess) {
              callbackSuccess(data);
            }
          }, function(error){
            // console.log(error);
            if (callbackFail) {
              callbackFail(error);
            }
          })
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

      return collection;
    } // function
  ]); // module

}());