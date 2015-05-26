'use strict';

(function(){

  var module = angular.module('thunder.api.services', ['ngResource']);

  module.factory('Api', [ '$resource',   
    function($resource) {
      return {
        InsuredUser: $resource('/api/v1/insured_users/:collectionCtrl:id/:memberCtrl', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    create: {
                      method: 'POST',
                      isArray: false
                    },
                    add: {
                      method: 'POST',
                      params: {
                        collectionCtrl: 'add'
                      },
                      isArray: true
                    },
                    addItem: {
                      method: 'POST',
                      params: {
                        memberCtrl: 'additem'
                      },
                      isArray: true
                    },
                    search: {
                      method: 'GET',
                      params: {
                        collectionCtrl: 'search'
                      },
                      isArray: true
                    },
                  }),
        Item: $resource('/api/v1/items/:collectionCtrl:id/:memberCtrl', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    toggleLike: {
                      method: 'POST',
                      params: {
                        memberCtrl: 'toggle_like'
                      },
                      responseType: 'json'
                    },
                    // get: {
                    //   method: 'GET',
                    //   // params: {
                    //   //   // collectionCtrl: 'metric2'
                    //   //   // memberCtrl: 'mapreduce'
                    //   // },
                    //   isArray: false,
                    //   responseType: 'json'
                    // },
                    
                  }),
        Comment: $resource('/api/v1/comments/:collectionCtrl:id/:memberCtrl', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    create: {
                      method: 'POST',
                      isArray: false
                    },
                  }),
        Like: $resource('/api/v1/likes/:collectionCtrl:id/:memberCtrl', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    create: {
                      method: 'POST',
                      isArray: false
                    },
                  }),
        Instagram: $resource('/api/v1/instagrams/:collectionCtrl:id/:memberCtrl', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    metric: {
                      method: 'GET',
                      params: {
                        collectionCtrl: 'metric'
                      },
                      isArray: true
                    },
                    mapreduce: {
                      method: 'GET',
                      params: {
                        // collectionCtrl: 'metric2'
                        memberCtrl: 'mapreduce'
                      },
                      isArray: true
                    },
                    mapreduce_join_mslocation: {
                      method: 'GET',
                      params: {
                        // collectionCtrl: 'metric2'
                        memberCtrl: 'mapreduce_join_mslocation'
                      },
                      isArray: true
                    },
                  }),
      }// end return
    } // end function
  ]); // end module  

}).call(this)
