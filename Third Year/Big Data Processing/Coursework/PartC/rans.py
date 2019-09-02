import pyspark
import re

sc = pyspark.SparkContext()

#we will use this function later in our filter transformation
# def wallet_key(line):
#     try:
#         fields = line.split(',')
#         if len(fields) == 4 and fields[3]== '{1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}':
#             float(fields[1])
#             return True
#         else:
#             return False
#
#     except:
#         return False
# ###1.Read file
# ####################Do this once as it there is a problem whenrunning it#################################################################################
# vout_data = sc.textFile("/data/bitcoin/vout.csv")
# #1.Filter Vout_data according to the Publick key
# filterWallet = vout_data.filter(wallet_key).map(lambda l: l.split(','))#call def wallet_key and filter according to the key value
# total = filterWallet.map(lambda f: "{}, {}, {}, {}".format(f[0], f[1],f[2], f[3]))
# total.repartition(1).saveAsTextFile("RansomwareFiltered")
# Example format output
###########################################Filtered out put data ##################################################
# 3ab4856aa7e6a415d421485813ec022bf20c10f951e7c826b6c24cded940cf0c , 2.14995968, 0, {1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}
# 56d3337adb3ebe55cca9fe288289c4ab143d98d20f54cba9643e783d5d5c887c , 500, 0, {1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}
# 82567ce47f8a339545cdbbdbfaca160e2a940d93fc0516bf7ee441e7744aa6c6 , 1, 0, {1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}
# 8b5ec77e7d8dc4546e53eec84f44d2b1339bdd3c6b92bcbc21bede762ccac598 , 5, 0, {1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}
# 0e8bc55c7f5dd1ffdbd8b73abf004b0036a247fcedcc371603c656c3ddedaefa , 17, 0, {1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}
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
# vout_data = sc.textFile("RansomwareFiltered")
# vout_function = vout_data.filter(getFloat).map(lambda l: l.split(','))
# vout_split = vout_function.map(lambda l: ((l[0]),(float(l[1]))))#Worked
# # ('3a04922b92398a198ab9e2e279f62427b6883b67849c24f69b3bd53cbe9c518c', 12.63)
# # ('2cc3d7fdb294b6658d7cb8172838a4e7f3424eef9be4a9e80530748d13b32051', 23.0)
# # ('0fb203423dae98af71b067bacc5375e7a81c7f59665fe5784df552714bcdb9cc', 60.0)
# # ('8ad19ef13213ff315ba40f353b2f38a08910913c20138ecaf2eedcd5399505c7', 5.0)
# # ('aed7a43e0c3a2afff1cc4d3a2893e41d4c31d45e22610b9d09e1e51758fc1fa9', 0.5552873)
#
# for line in vout_split.take(5):
#     print (line)
#
# vin_data = sc.textFile("/data/bitcoin/vin.csv")
# vin_split = vin_data.map(lambda l: l.split(','))
# vin = vin_split.map(lambda l: "{},{},{}".format(l[0],l[1],l[2]))
# vin_second_split = vin.map(lambda l: l.split(','))
# vin_f_join = vin_second_split.map(lambda l: ((l[0]),(l[1],l[2])))
# ##################################################################
# # ('f4184fc596403b9d638783cf57adfe4c75c605f6356fbc91338530e9831e9e16', ('0437cd7f8525ceed2324359c2d0ba26006d92d856a9c20fa0241106ee5a597c9', '0'))
# # ('a16f3ce4dd5deb92d98ef5cf8afeaf0775ebca408f708b2146c4fb42b41e14be', ('f4184fc596403b9d638783cf57adfe4c75c605f6356fbc91338530e9831e9e16', '1'))
# # ('591e91f809d716912ca1d4a9295e70c3e78bab077683f79350f101da64588073', ('a16f3ce4dd5deb92d98ef5cf8afeaf0775ebca408f708b2146c4fb42b41e14be', '1'))
# # ('12b5633bad1f9c167d523ad1aa1947b2732a865bf5414eab2f9e5ae5d5c191ba', ('591e91f809d716912ca1d4a9295e70c3e78bab077683f79350f101da64588073', '1'))
# ####################################################################
#
#
# # #3.Join both datasets--> vin and filterWallet
# first_join = vin_f_join.join(vout_split)
#
# # ('472927c5c7b1a50a998b49a97285021d94944380213529aff22aa8aa1219d443', (('8a7d6d9679555fd5a604f3bd806ecdd886a7e337041c554483f83dd3ef70eb7b', '0'), 5.53))
# # ('3a04922b92398a198ab9e2e279f62427b6883b67849c24f69b3bd53cbe9c518c', (('1616ac9d9d78ddf21d4d8467ec905b2d1dcf389237641cfdddc204628b86ee3d', '0'), 12.63))
# # ('2ac3de78b4ad32411bc50174e7e2ab9d2ee6759e477b800107546e9408cf744a', (('3216c6cb12da0b0ad5e6ac81294e20f7c35c3a2e1529bb29e1701e12b795825b', '2'), 3.94))
# # ('0fb203423dae98af71b067bacc5375e7a81c7f59665fe5784df552714bcdb9cc', (('e12444b66b066fb9652b4f02edbecc768059b616efaafe3d11497fd4b334cf19', '0'), 60.0))
# # ('15dbee025b38e823ede2b7a33ecbe85f32d0a2f9520a04595770e5687eccee5a', (('2b0a2fd3f978cd6095b065ed5823953a08c4686c181389092850c8ad8218e583', '1'), 174.87045254))
#
# first_hadoop = first_join.map(lambda l: "{},{},{},{}".format(l[0],l[1][0][0],l[1][0][1],l[1][1]))
# ############################# first Join ######################################################################
# # 6265c711d861ede9b3fd2774243e96169065b2e1f6847b8ea80dc2d75d92d89f,165427728e3915623df58dc069b611c65bc5c9b7900414eae39b44f9f1c7cc7e,0,12.1
# # 15dbee025b38e823ede2b7a33ecbe85f32d0a2f9520a04595770e5687eccee5a,4ee5727f39bcd7a932ed1c464346457cddf300b4cee0fcc40860fc474cf3f9c5,0,174.87045254
# # 2ac3de78b4ad32411bc50174e7e2ab9d2ee6759e477b800107546e9408cf744a,4576620602200de59c8211c4c0f6893ddc03b9670b4c75e9e78e0915c1a0bd3b,0,3.94
# # 83796a7652fd7d1838a699e89f5f7045a67e2c8efb72a4bc057f40652d310327,3ba40d392351673c618f3081c58a42ec6a0d7a6985a4336956bfa129fd5ff7a8,0,177.08340571
# # 83796a7652fd7d1838a699e89f5f7045a67e2c8efb72a4bc057f40652d310327,b7c143e218f161fee4ca352137075e8f8e002adb4346a64dd9471e73cd7d25b0,0,177.08340571
# ############################################################################################
# # for line in first_hadoop.takeSample(False,5):
# #     print (line)
# first_hadoop.repartition(1).saveAsTextFile("RansomwareFirstJoin")
# ##(hash, (( tx_has, vout),1))
########################################################################################################################################################
#################################################   PART II ####################################
##### Coment top one ##################
# #All the above is commented as we not longer need that and because it has been saved sn more smaller dataset in the cluster
# # #5.Second Join
#
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
# vin_hadoop = sc.textFile("RansomwareFirstJoin")
# vin_function = vin_hadoop.filter(createFloat).map(lambda l: l.split(','))
# vin_f_join = vin_function.map(lambda l: ((l[1],l[2]),(l[0],float(l[3]))))#Worked

# for line in vin_split.takeSample(False,5):
#     print (line)
# (('5415f1f6c711f485f05281dce18529cb2c2b245802e6b54cc6aa85e7d349ace0', '1'), ('83d33cb77b2a7b7a4e958a15629e5f3c04eb48bac897bf0b9e9da20c7e63cf57', 3.97))
# (('c4979eab4aa60f62c650ffdf3801afd9a4867027f69d3a52e197dd4d0db6d752', '0'), ('472927c5c7b1a50a998b49a97285021d94944380213529aff22aa8aa1219d443', 5.53))
# (('8d23cdf7f6355df00f5a24662256a8aa74062439c9605da0c65731a9ef350388', '0'), ('47f1dd4af19a5a4175ad2f85224fd654c785b5c9c65405ecda4f8bee3fa43155', 127.0))
# (('e3a4f281e0a74969f4b794fa481de45fe9c3addb24a9fb4b3315c0a0ec28558b', '0'), ('573824c26219da5e99421ee7f32055ece092928b76eaea59a76986cb35b92139', 7.44))
# (('bec54b3a43b87c2a0808f2f9aea5c2dfa233b40936af985a66b34611e84ca847', '0'), ('2cc3d7fdb294b6658d7cb8172838a4e7f3424eef9be4a9e80530748d13b32051', 23.0))
# #l[1] --> tx_hash
# #l[2] --> vout
# #l[0] --> txid(vin) == hash(vout)
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
# vout_f_join = vout_function.map(lambda l: ((l[0],l[2]),(float(l[1]),l[3])))
#
# second_join = vout_f_join.join(vin_f_join)
# for line in second_join.takeSample(False,5):
#     print (line)
################  Second Join Printed out ####################################################
# (('608191db40b126182d69471a2232d5e1f40db93ae28a5c2a9c27b7956b412008', '0'), ((2.0, '{19LHsVsHVbgtevDenVb2CNTDPM5hjxsBqU}'), ('f5a11ed4a92180383657c0ed0da1c61798c0552904a49b94a81704cc754574a9', 200.0)))
# (('f3c8cc55a6dd480339e43ceee318bd01c1e6276f93bf95ec1ffc55f47cfd660e', '0'), ((0.1, '{1BHbFDD36kWrDwEKAAj7aMjcm4ix8SZUFb}'), ('472927c5c7b1a50a998b49a97285021d94944380213529aff22aa8aa1219d443', 5.53)))
# (('3c498aeae0c80bc22df5b629ca1c98daedf0eb18bc4cdb331a3e17cd9c8a42a5', '0'), ((0.05759139, '{16PAyZrQxRmAq6FALVbAPdJtL5QdaiBtBU}'), ('a90e74355328313412c3979c2ad4ebf625aded35aeae1a07ed20347dcf4e2c1a', 2.73)))
# (('bf72d77e8493c2fad89a0ebed6abe3d086b0538f388840c61bd68c7af0114548', '2'), ((0.01984443, '{1CqBKRh3zHHv9QJQnyKdaEefJzubyALfh3}'), ('cc02dd4ba41236fbf04e38ec3de4126971a9c6d588989cd57bd63fd256db309b', 7.64)))
# (('544b2940c08a805b536afd9c927218299ded87966975b0b48495038f5e79ee33', '0'), ((10.0, '{18tmXu82Lqqwxw6F9JMJiTHV4VJTMSy3W6}'), ('b99600faeb9523cf83deb115f1e62789eeee9687b86b6137c72b2ebc4dc2cd81', 100.0)))
##############################################################################################
# money_from = second_join.map(lambda f: "{}, {}, {}, {}".format(f[1][1][1], f[1][0][1], f[1][0][0], f[1][1][0]))

# (transaccion receiveing money, publick key, amount sent in the transacaction, total receive by C)


# money_from.repartition(1).saveAsTextFile("RansomwareSecondJoin")


# # #7.Map the second_joina dn get the values we want: amount(value) and wallet
# # for line in money_from.take(5):
# #     print(line)
# # f5d4213d3c2ab448bba24ea61a80e20373de10729abccd991c018c016a32c72f, {1EGUxJFoC5pzkhgw7kPCBZBQRGTPHYYj36}, 0.0458
# # cc02dd4ba41236fbf04e38ec3de4126971a9c6d588989cd57bd63fd256db309b, {1GJFuvEimRtdp6jCrP2fG7YV6E4gXNk5eK}, 0.05556
# # 83540b7ff6da74fbbc13480f138dd4c40bd9b4450fabe0889d450057e3fcfc09, {15ijGRuHG4mC5KQeivWfjyfimZnmoFxZw8}, 0.0468428
# # 83540b7ff6da74fbbc13480f138dd4c40bd9b4450fabe0889d450057e3fcfc09, {1M9Mc2csz6ryXsmQcnn6JNmBnLgGP3NJKb}, 0.04950495
# # c58b08cf69cee25aacf2e699956a507ce952de6799ebb582ead7f0ced289f94b, {12hRMdc66QEpueAaA7gpQ8ZQBWrf1yG4gd}, 0.02364
#
# #(('1dd6bd06b3866c71cd6ad01fcbca56e3ff863128bb1fe078b0210facef708ade', '0'), ((2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}'), 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375'))
# #txid:        f[1] --> ((2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}'), 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375')
# #             f[1][1] --> 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375'
# # publickey:    f[1] --> ((2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}'), 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375')
# # #           f[1][0] -->(2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}')
# # #           f[1][0][1] --> {1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}
# # #publickey: f[1]--> ((2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}'), 'c20079ca4a978a8b6eea1ba7fc2e3603b91dd73e34b7d381fa527d05ab3be375')
# # #           f[1][0]--> >(2.0, '{1GovQ81qq8JyBAzcqK8T6CSUxpHf7BuFF8}')
# # #           f[1][0][1] -- > 2.0
# ##MATCHING data

############################################### PART III #####################################################
# ##ONCE THE FILE RANSOMWARE HAS BEEN CREATED COMMENT THE TOP
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

trans_data = sc.textFile("RansomwareSecondJoin")
# 2.14995968, {1KcUUDDPLmu6CSGcgRifM168u3HE7Ysfb}, 0.04975124, 3ab4856aa7e6a415d421485813ec022bf20c10f951e7c826b6c24cded940cf0c
# 5.53, {1MXwj1XzqgFQeRRBKYWqhsSHpqX9c3yNj1}, 0.05491153, 472927c5c7b1a50a998b49a97285021d94944380213529aff22aa8aa1219d443
# 5.15425962, {1KcUUDDPLmu6CSGcgRifM168u3HE7Ysfb}, 0.45059289, c394daea9e68b1f6de4969072f631952c902a7e5f611c3998ceb665fb504c712
# 4.2, {1MJVdHiUo88hq9EYUKjtYskVLyt2xBP6h5}, 0.03171079, c58b08cf69cee25aacf2e699956a507ce952de6799ebb582ead7f0ced289f94b
# 9.99, {1DbpDhPgxECb7DEHWRArt4VEjFhttmjc6z}, 0.0665, 83540b7ff6da74fbbc13480f138dd4c40bd9b4450fabe0889d450057e3fcfc09
# 200.0, {17Lx64PZ7uEV3owFgPTAUA8tcA8Quhi4zf}, 2.0, f5a11ed4a92180383657c0ed0da1c61798c0552904a49b94a81704cc754574a9
trans_function = trans_data.filter(getFloat).map(lambda l: l.split(','))
# vout_t_bykey = trans_function.map(lambda l: "{}, {}, {}".format(l[3],l[1],float(l[2])))
# # for line in vout_t_bykey.takeSample(False,5):
# #     print(line)
# vout_t_bykey.repartition(1).saveAsTextFile("Transactions_Key_keySent")

vout_total_receive = trans_function.map(lambda l: "{}, {}, {}".format(l[3],l[1],float(l[0])))
# for line in vout_t_bykey.takeSample(False,5):
#     print(line)
vout_total_receive.repartition(1).saveAsTextFile("TotalReceive")
