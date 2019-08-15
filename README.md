
# Restaurant Server

## A Vapor swift backend server for the Ordering, Kitchen, Billing and Advertising aspects of a restaurant.

### Address: http://localhost:8080/
- - - -
**Setting Up and Using the Server**:
1. Run the Xcode Project (make sure Run scheme and mac is selected as your device).
2. Visit http://localhost:8080/ on your browser. This is the home page of the server. If you visit the billing or kitchen links on the website, it will be blank as no orders have been sent, yet.
3. Also, there are no menu items on the servers menu. You could add custom menu items using the RestaurantAdmin mac app. For now, let’s just load a few preset items. Go to your terminal and type the following command and press enter -> curl -X POST http://localhost:8080/init.
4. It show a response stating that sample items have been initialised.
5. You can now use the iOS app to order the loaded items.
6. After ordering, the kitchen route will show the orders sent to the kitchen. On serving the order, press the ’served’ button.
7. Now the served orders will be present in the bills route. This part is for the billing counter, where the customer can pay the bill. 

<img src="https://imgur.com/2nXdmrm.png" alt="X" style="width:500px;height:500px">
</p>
