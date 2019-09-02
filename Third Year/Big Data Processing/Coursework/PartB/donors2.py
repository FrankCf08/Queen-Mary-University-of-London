import pyspark
import re

sc = pyspark.SparkContext()
#we will use this function later in our filter transformation
# def wallet_key(line):
#     try:
#         fields = line.split(',')
#         if len(fields) == 4 and fields[3]== '{1HB5XMLmzFVj8ALj6mfBsbifRoD4miY36v}':
#             float(fields[1])
#             return True
#         else:
#             return False
#
#     except:
#         return False
# # ###1.Read file
# # ####################Do this once as it there is a problem whenrunning it#################################################################################
# vout_data = sc.textFile("/data/bitcoin/vout.csv")
# # #1.Filter Vout_data according to the Publick key
# filterWallet = vout_data.filter(wallet_key).map(lambda l: l.split(','))#call def wallet_key and filter according to the key value
# wallets = filterWallet.map(lambda f: "{}, {}, {}, {}".format(f[0], f[1],f[2], f[3]))
# wallets.repartition(1).saveAsTextFile("FilteredPartB")
# Example format output
# ###########################################Filtered out put data ##################################################
# 1bd651da6e6ca7ce5be790a132912b80e2ad4fabd162a0874f9d710f14f77f9a, 0.0095, 0, {1HB5XMLmzFVj8ALj6mfBsbifRoD4miY36v}
# 055703ea6f03ded6c73e6188d6f908011f3ab0f6f27bf675b7f9f4eb478c2482, 0.2, 0, {1HB5XMLmzFVj8ALj6mfBsbifRoD4miY36v}
# 95194cfda11300a32b80a168025562001e733c6131911d7f28887f7c69e6b3be, 1, 1, {1HB5XMLmzFVj8ALj6mfBsbifRoD4miY36v}
# f6794be85c8dee8a81e332013b97f2c04f036971e7568ad4e6c6ccf13f130980, 0.0141, 0, {1HB5XMLmzFVj8ALj6mfBsbifRoD4miY36v}
# 8d30a3b54818ee6c275d2125ecc73ede7471cfcc775a2c2845724125206fc2f5, 0.1, 0, {1HB5XMLmzFVj8ALj6mfBsbifRoD4miY36v}
####################################################################################################################
# ##2 Using the filtered data according to the puclick key we found 115 lines with it
# #2.1 Read and Map the data in
# ##ONCE THE FILE RANSOMWARE HAS BEEN CREATED COMMENT THE TOP
# def getFloat(line):
#     try:
#         fields = line.split(',')
#         if len(fields)!= 4:
#             return False
#         float(fields[1])
#         return True
#     except:
#         return False
#
# vout_data = sc.textFile("FilteredPartB")
# vout_function = vout_data.filter(getFloat).map(lambda l: l.split(','))
# vout_split = vout_function.map(lambda l: ((l[0]),(float(l[1]))))#Worked
#
# vin_data = sc.textFile("/data/bitcoin/vin.csv")
# vin_split = vin_data.map(lambda l: l.split(','))
# vin = vin_split.map(lambda l: "{},{},{}".format(l[0],l[1],l[2]))
# vin_second_split = vin.map(lambda l: l.split(','))
# vin_f_join = vin_second_split.map(lambda l: ((l[0]),(l[1],l[2])))
#
# # # #3.Join both datasets--> vin and filterWallet
# first_join = vin_f_join.join(vout_split)
#
# first_hadoop = first_join.map(lambda l: "{},{},{},{}".format(l[0],l[1][0][0],l[1][0][1],l[1][1]))
# # # ############################# first Join ######################################################################
# #fd7a0f4136389f831471be2e275a45620dfd9997f6439fec2cfcfbf007dc7771,db0269dcf1efc92456151f2347b7d68a36cf1ec5c75272668aca0377b3291fd3,0,0.43
# ae357fcd3acb89b81fa3280e1ee33e49584dabb2f24bef94b841566076325629,57fd08a40f654c9e00a03dfe4e1dcd1fd8564fcac79c51c1d5370236813674b1,1,0.001
# 8f427ede9b3418f425740d0f934aa37da27adee59469de52a4765f25b668b71a,4595448695e4808ef84326dd2e622015b5f8cb22bdba521101f10fe6135a0170,104,1e-08
# 067bf093d9c947feda1d5f8294f1fa81be29235779eccd75388ab49f067500e6,759591a0138c5b9e38677ba2a4bdff9a84c8e708054f5015a8916d62998cd9a7,104,1e-08
# 52ab5cc7a4189fd1e354c17ad4303a582a6d4e478967ed36e3314afbf71fbc2e,d0a28e860ef29b833f9334696c6fa7542dda5779efe3ad9f46a7c0f6b2939e72,1,0.08
# # ############################################################################################
# # # # # for line in first_hadoop.takeSample(False,5):
# # # # #     print (line)
# first_hadoop.repartition(1).saveAsTextFile("FirstJoinPartB")
# # # ##(hash, (( tx_has, vout),1))
# ########################################################################################################################################################
# #################################################   PART II ####################################
# # ##### Coment top one ##################
# # # #All the above is commented as we not longer need that and because it has been saved sn more smaller dataset in the cluster
# # # # #5.Second Join
# # #
# def createFloat(line):
#     try:
#         fields = line.split(',')
#         if len(fields)!= 4:
#             return False
#         float(fields[3])
#         return True
#     except:
#         return False
#
# vin_hadoop = sc.textFile("FirstJoinPartB")
# vin_function = vin_hadoop.filter(createFloat).map(lambda l: l.split(','))
# vin_f_join = vin_function.map(lambda l: ((l[1],l[2]),(l[0],float(l[3]))))#Worked
#
# # for line in vin_split.takeSample(False,5):
# #     print (line)
# ##############################################################################################
# # fd7a0f4136389f831471be2e275a45620dfd9997f6439fec2cfcfbf007dc7771,db0269dcf1efc92456151f2347b7d68a36cf1ec5c75272668aca0377b3291fd3,0,0.43
# # ae357fcd3acb89b81fa3280e1ee33e49584dabb2f24bef94b841566076325629,57fd08a40f654c9e00a03dfe4e1dcd1fd8564fcac79c51c1d5370236813674b1,1,0.001
# # 8f427ede9b3418f425740d0f934aa37da27adee59469de52a4765f25b668b71a,4595448695e4808ef84326dd2e622015b5f8cb22bdba521101f10fe6135a0170,104,1e-08
# # 067bf093d9c947feda1d5f8294f1fa81be29235779eccd75388ab49f067500e6,759591a0138c5b9e38677ba2a4bdff9a84c8e708054f5015a8916d62998cd9a7,104,1e-08
# # 52ab5cc7a4189fd1e354c17ad4303a582a6d4e478967ed36e3314afbf71fbc2e,d0a28e860ef29b833f9334696c6fa7542dda5779efe3ad9f46a7c0f6b2939e72,1,0.08
# ##############################################################################################
# # #l[1] --> tx_hash
# # #l[2] --> vout
# # #l[0] --> txid(vin) == hash(vout)
# ##l[3] --> value
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
# vout_f_join = vout_function.map(lambda l: ((l[0],l[2]),(float(l[1]),l[3])))
#
# second_join = vout_f_join.join(vin_f_join)
# # # for line in second_join.takeSample(False,5):
# # #     print (line)
# # ################  Second Join Printed out ####################################################
# # # (('608191db40b126182d69471a2232d5e1f40db93ae28a5c2a9c27b7956b412008', '0'), ((2.0, '{19LHsVsHVbgtevDenVb2CNTDPM5hjxsBqU}'), ('f5a11ed4a92180383657c0ed0da1c61798c0552904a49b94a81704cc754574a9', 200.0)))
# # # (('f3c8cc55a6dd480339e43ceee318bd01c1e6276f93bf95ec1ffc55f47cfd660e', '0'), ((0.1, '{1BHbFDD36kWrDwEKAAj7aMjcm4ix8SZUFb}'), ('472927c5c7b1a50a998b49a97285021d94944380213529aff22aa8aa1219d443', 5.53)))
# # # (('3c498aeae0c80bc22df5b629ca1c98daedf0eb18bc4cdb331a3e17cd9c8a42a5', '0'), ((0.05759139, '{16PAyZrQxRmAq6FALVbAPdJtL5QdaiBtBU}'), ('a90e74355328313412c3979c2ad4ebf625aded35aeae1a07ed20347dcf4e2c1a', 2.73)))
# # # (('bf72d77e8493c2fad89a0ebed6abe3d086b0538f388840c61bd68c7af0114548', '2'), ((0.01984443, '{1CqBKRh3zHHv9QJQnyKdaEefJzubyALfh3}'), ('cc02dd4ba41236fbf04e38ec3de4126971a9c6d588989cd57bd63fd256db309b', 7.64)))
# # # (('544b2940c08a805b536afd9c927218299ded87966975b0b48495038f5e79ee33', '0'), ((10.0, '{18tmXu82Lqqwxw6F9JMJiTHV4VJTMSy3W6}'), ('b99600faeb9523cf83deb115f1e62789eeee9687b86b6137c72b2ebc4dc2cd81', 100.0)))
# # ##############################################################################################
# money_from = second_join.map(lambda f: "{}, {}, {}, {}".format(f[1][1][1], f[1][0][1], f[1][0][0], f[1][1][0]))
#
# # # #(('1dd6bd06b3866c71cd6ad01fcbca56e3ff863128bb1fe078b0210facef708ade', '0'), ((2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}'), 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375'))
# # # #txid:        f[1] --> ((2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}'), 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375')
# # # #             f[1][1] --> 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375'
# # # # publickey:    f[1] --> ((2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}'), 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375')
# # # # #           f[1][0] -->(2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}')
# # # # #           f[1][0][1] --> {1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}
# # # # #publickey: f[1]--> ((2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}'), 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375')
# # # # #           f[1][0]--> >(2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}')
# # # # #           f[1][0][1] -- > 2.0
# # # ##MATCHING data
#
# # (Amount sent by the key, puclickey, total amount in the transafer block receive by the transfer number, transfer number)
# money_from.repartition(1).saveAsTextFile("SecondJoinPartB")
# # 2.0, {1HF3JRLXmcezqPRASDUX6fF9ekhfHpQ6vM}, 0.11, 3293d302b7dbe97038211b4f84cd01ddc8f7a7eedf1e32fc19940efc56bfad87
# # 0.0001, {17eVnH4vYPqocvcr7NTdCCBTvF6ifGCbvj}, 9.9996, 62c7a8fe8e089e615da3a8c0ae7f3dc9128ee6a981728a8c4cece94ab002fca9
# # 0.13, {1DxaGSf323LH99swpFhFKquMwHGv3x2XYE}, 8e-05, 7eba2b540b543233f4c7d98262f2cefe25ef73617c3256f2e2a7906b45b7fcb3
# # 0.036, {1JsSY9txvjR8Yp8Dyc5w5s4oUCqe9VqcwW}, 1.0, c6c61ea73fba2caf963454f1938804c6469002786ee0f6ec9dbd6c88c856b592
# # 0.00148, {1M96vbfWHd2G5K32rxv7VzEAsuWVxBeFgB}, 0.015, 730d1957eb15c37bbdd56de81bfd0ee3fd08952c30f7307181524107a74d9f55
############################################### PART III #####################################################
# # ##ONCE THE FILE RANSOMWARE HAS BEEN CREATED COMMENT THE TOP
def getFloat(line):
    try:
        fields = line.split(',')
        if len(fields)!= 4:
            return False
        float(fields[0])
        float(fields[2])
        return True
    except:
        return False

trans_data = sc.textFile("SecondJoinPartB")

trans_function = trans_data.filter(getFloat).map(lambda l: l.split(','))
vout_total_donate = trans_function.map(lambda f: (f[1], float(f[0])))
#(puclicKey, amount donated)

# # for line in vout_t_bykey.takeSample(False,5):
# #     print(line)
# #vout_total_receive.repartition(1).saveAsTextFile("PartBFinal")
top10 = vout_total_donate.takeOrdered(10, key = lambda x: -x[1])
#top10.saveAsTextFile("PartBFinal")

for record in top10:
    print("{} - {}".format(record[0],record[1]))

##########################   Top Ten #######################################################
 # {13vFf3MZKxSA3Q9e14c8xUXbMpHQn1wCgq} - 90.0    -- $ 362,818.80 (2011-06-28 21:06:01)
 # {17zeTMh8xXeXXjZnbULXV3g3t3f7pftnEh} - 90.0    -- $ 362,442.60 (2011-06-28 21:06:01)
 # {1BiZSHyPuVLiPNV7GTg5okStXKm1FTNSb7} - 74.3    -- $ 299,216.50 (2011-10-24 23:57:58)
 # {1LNWw6yCxkUmkhArb2Nf2MPw6vG7u5WG7q} - 70.0    -- $ 282,503.20 (2011-10-25 23:38:26)
 # {1FZVyaDzeQD2N85Ea6kbcW2LW3FdUxrfdP} - 63.33333 -- $ 255,593.05 (2012-03-18 18:28:34)
 # {161SkPXMWuMvekXVY329i7sBNJ9oyTPuDr} - 56.3327931 -- $ 56.3327931 (2011-12-26 10:31:37)
 # {13FUw7Sd5jFWgbadvj4oZ3r7oz4Aw5hAWX} - 56.3327931 -- $ 227,060.59 (2011-12-26 10:31:37)
 # {13WYWuDa6NdqnXY3NNnS3a5xNhzAXxdynb} - 56.3327931 -- $ 226,968.77 (2011-12-26 10:31:37)
 # {1GYMagx3YrWr9C8a2itabnw7zftP7suCtW} - 56.3327931 -- $ 226,968.77 (2011-12-26 10:31:37)
 # {17SC6Ps71YMtexXjejdcV7HFJDYXKYDrKY} - 50.0  -- $ 201,443.50 (2011-10-25 07:40:38)
########################################################################################
