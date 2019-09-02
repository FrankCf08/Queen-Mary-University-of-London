import pyspark
import re

sc = pyspark.SparkContext()

#we will use this function later in our filter transformation
def wallet_key(line):
    try:
        fields = line.split(',')
        if len(fields) == 4 and fields[3]== '{1HB5XMLmzFVj8ALj6mfBsbifRoD4miY36v}':
            float(fields[1])
            return True
        else:
            return False

    except:
        return False

####################Do this once as it there is a problem whenrunning it#################################################################################
vout_data = sc.textFile("/data/bitcoin/vout.csv")
# #1.Filter Vout_data according to the Publick key
filterWallet = vout_data.filter(wallet_key).map(lambda l: l.split(','))#call def wallet_key and filter according to the key value
vout_wallet =  filterWallet.map(lambda l: ((l[0]),(float(l[1])))) #l[0] -- > hash
#
#
# #TRying outout WORKS
# #print(vout_wallet)
# # for line in filterWallet.takeSample(False, 5):
# #    print (line)
#
# #2.Read and Map the data in
vin_data = sc.textFile("/data/bitcoin/vin.csv")
###############Printing vin_data WORKS##################
#  for line in vin_data.take(5):
#    print (line)
#######################################################
vin = vin_data.map(lambda l: ((l.split(',')[0]),(l.split(',')[1],l.split(',')[2])))
# #l[0] --> txid as a Key
#
# # for line in vin.take(5):
# #     print (line)
#
# #3.Join both datasets--> vin and filterWallet
first_join = vin.join(vout_wallet)
#first_join = vout_wallet.join(vin)
##(hash, ( (tx_has, vout),1))
########################################################################################################################################################
# #########################  Example output ###############################################################################
# ('e0f06407e63436cc2d495564bb163f31e68e641ca91489aed48e601bbb2336d8', (0.75, ('f8504a46d6e79bcfbbed15e9b178c5c1d521724e21949cdc5694a92ff83326a1', '1')))
# ('e78d6ad1f9d5f633908820ff5f0d1367eabc842e87976d55353100ca5563661a', (0.1, ('d7a6d1fa83f70995a5f723d3e5718bcf6a5c825d8156bacd39137968e30c6112', '8')))
# ('e78d6ad1f9d5f633908820ff5f0d1367eabc842e87976d55353100ca5563661a', (0.1, ('3334521a1525cfaa7c621baed724211b01379148d21de9c05899768e2c0b7a76', '8')))
# ('e78d6ad1f9d5f633908820ff5f0d1367eabc842e87976d55353100ca5563661a', (0.1, ('f79f36677c8302f7c2260af282ae03fae152b436c642c1497e21400ad2e09e7e', '10')))
# ('e78d6ad1f9d5f633908820ff5f0d1367eabc842e87976d55353100ca5563661a', (0.1, ('871d40b58d61cebf685b7273a55847552fcbebcf68fe6ce65a4a8e503bc179e9', '8')))
##########################################################################################################################

#4. Save in Hahoop(Save it only once)
total_firstJoin = first_join.map(lambda f: "{}, {}, {}".format(f[1][1][0], f[1][1][1], float(f[1][0])))

total_firstJoin.repartition(1).saveAsTextFile("firstJoinPartB")#It'll give a single textfile with all the data inside
#first_join.saveAsTextFile("firstJoin")#Returns 256 text Files sorted ramdonly

################      PART II            ###############################
#
# #5.Second Join
# vin_hadoop = sc.textFile("firstJoin")
# ###########WORKS#########################
# # for line in vin_hadoop.take(5):
# #     print (line)
# #########################################
# ####################################################Example Output#######################################################################################
# # ('3332b80c90f0f0bee282b65fcdac93823b00d443eecf60c240ff09e86e28094d', (('211beb9fa90775cab016ae8709b6324b33c004482976d5619f49695ec8d3d8c8', '0'), 1))
# # ('66b16794e9fe6d918e739d4ee5a9f0cb3b54895eacd327760528aeff3f4cb17a', (('62adde783bad3d6eebdef2df32ab0a15138cfbfdf14de35a700b532dffd34e45', '0'), 1))
# # ('82e3a07c6d5e9765ff115fc8a28431942215e237ea86cdcb798f856484f587e8', (('63d69e134813536ef08c51974be15a0358b3d6e2a4b4ea0267a93b68ebe4d7ce', '0'), 1))
# # ('5516f3ef6df77b0f2873901ee8f308f445825a3b0fd96758e9c2fdde12e8c313', (('40ff70d0e894ac73deba799b83f00f11bce32dc8372937eabdea68d58032afd7', '0'), 1))
# # ('0f29fb502200d44f43d3dcdf6ec9346f7176218ee78b6f2f7aad46b55aba3863', (('4dbc3233d5cbfcebeb5b68a8924a9cd46ffa45485bc9d2d4a57408823dff7608', '1'), 1))
# ############################################################################################################
# #6. Map the values from the vin_hadoop
# vin_split = vin_hadoop.map(lambda l: l.split("'"))
# vin_new = vin_split.map(lambda l: ((l[3],l[5]),(1)))
#
# def makeFloat(line):
#     try:
#         fields = line.split(',')
#         if len(fields)!= 4:
#             return False
#         float(fields[1])
#         return True
#     except:
#         return False
#
# vout_data = sc.textFile("/data/bitcoin/vout.csv")
# vout_function = vout_data.filter(makeFloat).map(lambda l: l.split(','))
# vout_split = vout_function.map(lambda l: ((l[0],l[2]),(float(l[1]),l[3])))
#
# second_join = vout_split.join(vin_new)
# #((has,n), ((value[float], puclicKey),1))
# second_join.saveAsTextFile("secondJoin")
# ########### WORKS#########################
# # for line in second_join.take(5):
# #     print (line)
# #########################################
# ######################################        EXAMPL Output #########################
# # (('3589c920d21b6a0be5c553a261cb85284c2ece50e967f91228938f38f91a3c5c', '0'), ((0.12935, '{14SNoH17pgQWeBMg6x2r5vZHC4X7PEL1pZ}'), 1))
# # (('bb0956ffc6f003488a8049147132d75e0574e83a9da5a0019e12c5b1762447c4', '0'), ((0.0005872, '{1GNjwe6SZTtJa83t1qSiyMTcMTiNT8pMbr}'), 1))
# # (('f5f3346539919d6560d76a8691868f3760833752788698c6d6a8774c334d45fd', '1'), ((19.08, '{1L5geyU64RWQiUT4BV2xD4JMFe2fniSJET}'), 1))
# # (('8bfec37243bd0a278be1aff8ee8d392aec5718f90baf095ac7f38609714c4139', '1'), ((0.2, '{1PMwrmT32UGro7ufcQdsoWzZiQYq7L15sj}'), 1))
# # (('c8b5d44e8687e7f7dd3a63b5a6450b6217a5e3eceeba63d66cd4d392e72c9e46', '1'), ((0.5, '{12g8C4pc5c2jYset4jdmoKtXZoQQX5c6HT}'), 1))
# ####################################################################################
#
# #7.Map the second_joina dn get the values we want: amount(value) and wallet
#
# value_publickey = second_join.map(lambda f: (f[1][0][0], f[1][0][1]))
# #amount:    f[1] --> ((0.12935, '{14SNoH17pgQWeBMg6x2r5vZHC4X7PEL1pZ}'), 1)
# #           f[1][0] -->(0.12935, '{14SNoH17pgQWeBMg6x2r5vZHC4X7PEL1pZ}')
# #           f[1][0][0] --> 0.12935
# #publickey: f[1]--> ((0.12935, '{14SNoH17pgQWeBMg6x2r5vZHC4X7PEL1pZ}'), 1)
# #           f[1][0]--> (0.12935, {14SNoH17pgQWeBMg6x2r5vZHC4X7PEL1pZ}')
# #           f[1][0][1] -- > {14SNoH17pgQWeBMg6x2r5vZHC4X7PEL1pZ}
# value_publickey.saveAsTextFile("value_publickey")
#
# top10 = value_publickey.takeOrdered(10, key = lambda x: -x[0])
#
# for record in top10:
#     print("{} : {}".format(record[0],record[1]))
# ######################################        EXAMPL Output #########################
#
# # 46515.1894803 : {17B6mtZr14VnCKaHkvzqpkuxMYKTvezDcp}
# # 5770.0 : {19TCgtx62HQmaaGy8WNhLvoLXLr7LvaDYn}
# # 1931.482 : {14dQGpcUhejZ6QhAQ9UGVh7an78xoDnfap}
# # 1005.30353679 : {1LNWw6yCxkUmkhArb2Nf2MPw6vG7u5WG7q}
# # 806.13402728 : {1L8MdMLrgkCQJ1htiGRAcP11eJs662pYSS}
# # 806.08990209 : {1LNWw6yCxkUmkhArb2Nf2MPw6vG7u5WG7q}
# # 648.5199788 : {1ECHwzKtRebkymjSnRKLqhQPkHCdDn6NeK}
# # 637.04365574 : {18pcznb96bbVE1mR7Di3hK7oWKsA1fDqhJ}
# # 576.835 : {19eXS2pE5f1yBggdwhPjauqCjS8YQCmnXa}
# # 556.7 : {1B9q5KG69tzjhqq3WSz3H7PAxDVTAwNdbV}
#
# ####################################################################################
