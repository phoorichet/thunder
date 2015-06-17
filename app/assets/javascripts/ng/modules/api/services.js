'use strict';

(function(){

  var module = angular.module('thunder.api.services', ['ngResource']);

  module.factory('Api', [ '$resource',   
    function($resource) {
      return {
        Person: $resource('/persons/:collectionCtrl:id/:memberCtrl.json', {
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
        Coverage: $resource('/coverages/:collectionCtrl:id/:memberCtrl.json', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    search: {
                      method: 'GET',
                      params: {
                        collectionCtrl: 'search'
                      },
                      isArray: true
                    },                    
                  }),
        Rider: $resource('/riders/:collectionCtrl:id/:memberCtrl.json', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    search: {
                      method: 'GET',
                      params: {
                        collectionCtrl: 'search'
                      },
                      isArray: true
                    },                    
                  }),
        Insurance: $resource('/insurances/:collectionCtrl:id/:memberCtrl.json', {
                    id: '@id',
                    collectionCtrl: '@collectionCtrl',
                    memberCtrl: '@memberCtrl'
                  }, {
                    index: {
                      method: 'GET',
                      isArray: true,
                      responseType: 'json'
                    },
                    search: {
                      method: 'GET',
                      params: {
                        collectionCtrl: 'search'
                      },
                      isArray: true
                    },                    
                  }),
      }// end return
    } // end function
  ]); // end module  

}).call(this)
