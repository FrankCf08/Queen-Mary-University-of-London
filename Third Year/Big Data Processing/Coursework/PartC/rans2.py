import pyspark
import re

sc = pyspark.SparkContext()

##we will use this function later in our filter transformation
############################ PART I #################################################################
# def getVout(line):
#     try:
#         fields = line.split(',')
#         if len(fields) == 4:
#             float(fields[1])
#             return True
#         else:
#             return False
#
#     except:
#         return False
# ##1.Read file
# # ####################Do this once as it there is a problem whenrunning it#################################################################################
# vout_data = sc.textFile("/data/bitcoin/vout.csv")
# vout_split = vout_data.filter(getVout).map(lambda l: l.split(','))
# vout_f_join = vout_split.map(lambda l: ((l[0],l[2]),(float(l[1]),l[3])))

# #((hash, n),(value,publickey))
# vin_data = sc.textFile("/data/bitcoin/vin.csv")
# vin_split = vin_data.map(lambda l: l.split(','))
# vin_f_join = vin_split.map(lambda l: ((l[1],l[2]),(l[0])))
# #((tx_hash, vout), (txid))
# # # # #3.Join both datasets--> vin and filterWallet
# first_join = vin_f_join.join(vout_f_join)
# ############################### First Join Data  ####################################
# # (('2ccb81ebc719adce81721aa4122ced95cd6821787b9c95f99a8688f1b2436987', '0'), ('27cca7f4e57a9cb19ad584ed0141715e3105a15fe35bdbb02443d7112916734b', (60.80786012, '{15PqChGiLsfgCMFQMBWLRsU4azpi2VpQ9b}')))
# # (('db7ea8116a2878c60466d51835244c3ae7eebc57abb4d07720fe94345a43c918', '0'), ('23ca4e1bc234fa5b2a80a96796c90d9270fa6cfd66e9884e29f2aa4370a3363b', (0.64043136, '{1PPddaBVYHLUNBbU8vhhqKr5nUvBspL7v1}')))
# # (('71ed21106b884492b8a4a034b0af1d79aee9c54c3783186f5567b9190d69a72f', '1'), ('678333df8f88dad8865c26a1d0dc0c67ada5cfa0101fcd46aa0f9c3e0626382d', (0.01963823, '{15ZY5nbr2SLtAP22La7323uTBEsM9XxfTZ}')))
# ##################################################################
# first_hadoop = first_join.map(lambda l: "{},{},{},{},{}".format(l[0][0], l[0][1], l[1][0], l[1][1][1], l[1][1][0]))
# # # (hash or txid, vout or n, tx_hash(vin), publickey, amount)
# #(transaction which RANSOME receives the money, vout), (trsaction which RANSOME SENTS the money to, publickey which sent money, value)
# # c5cc08c5966dd232029fea32a7bcc11ba857865a22c98e1638725ecb13cb5c55,0,f62e4645cf647f33b336317d6c9c41c1724a36c64b06213c8851d7c482c5609c,{1E5Cgyh4xShEDjCuxzWwdvPzvuE5AeyNG4},0.16367
# # 8d2f0b24ff6180e63727e1a03a8cbd399edce3852c98a9a1ca3f1c9fbd1071aa,1,02ac027469a3f89192115d4c7779889f1b69e12c72541c7fa1a0f2096da559ae,{1L82syBuvHL3PAEghaP1W4H4fCoAdzFW2C},2.62928099
# # bcbbd939408763699e5758ebb6672ea745f34255bf62534fd7a20250a52a43bf,1,8dd570435f8dc00da019883799e5efe66f980f1940a2972cfbf88da030de27cf,{169y8E5sMG19iHEnc1n7zickcBG2yXEruy},4.39911314
# # for line in first_hadoop.takeSample(False, 5):
# #     print(line)
#
# def wallet_key(line):
#     try:
#         fields = line.split(',')
#         if len(fields) == 5 and fields[3]== '{1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}':
#             float(fields[4])
#             return True
#         else:
#             return False
#
#     except:
#         return False
# ransomeWallet = first_hadoop.filter(wallet_key).map(lambda l: l.split(','))#call def wallet_key and filter according to the key value
# #(transaction where money was sent, vout), (trsactions which money in coming from, publickey which sent money, value)
# wallet_format = ransomeWallet.map(lambda f: "{}, {}, {}, {}, {}".format(f[0], f[1],f[2], f[3], f[4]))
# #(transaction from whcih the Ransome acc receive the money, vout or n, transactions money is going from the Ransome Account, publickey of Ransome, amount sent by key)
#############################################   wallet_format Example ##########################################################
# 03a3dd55a10b207157c8ae537683d0d8ccaa55ead80d291076b57157ef26e48f, 0, 8189d6a4ee4436f4506d88f9bae29732a403cdfbab2885e903af4595432674c5, {1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}, 140.0
# 002772ca9a32556485d01f13e6f9cfbf8ccb78ae5a61711f3d901ca70549a67a, 2, 010c46be626c7f54a37aa301dce3aa927a7212d47d4526adb7d5d34b2eaf7cf3, {1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}, 29.01
# 3b33fc1f292e3efa63cf159b2850fb0ea1f153fc9f8ffa77db630ed730f5e1e2, 0, ac2099d653efe3ddfe558fc7b355d017c62d4d8e5716c3a5a35f3f32c88ef540, {1AEoiHY23fbBn8QiJ5y6oAjrhRY1Fb85uc}, 372.0
################################################################################################################################
# wallet_format.repartition(1).saveAsTextFile("RansomewarePartB")
######################################  PART II ###################################################
def getRan(line):
    try:
        fields = line.split(',')
        if len(fields) == 5:
            float(fields[4])
            return True
        else:
            return False

    except:
        return False

block_receive = sc.textFile("RansomewarePartB")
block_split = block_receive.filter(getRan).map(lambda l: l.split(','))
block_f_join = block_split.map(lambda l: ((l[2]),(float(l[4]))))
# #(trasactions where money is going to from the randome key, amount per block)
# for line in block_receive.takeSample(False, 3):
#     print(line)
######### Identifying publick keys receiving money #############################################
def getVout(line):
    try:
        fields = line.split(',')
        if len(fields) == 4:
            float(fields[1])
            return True
        else:
            return False

    except:
        return False

vout_data = sc.textFile("/data/bitcoin/vout.csv")
vout_split = vout_data.filter(getVout).map(lambda l: l.split(','))
vout_f_join = vout_split.map(lambda l: ((l[0]),(l[2], l[3], float(l[1]))))
# (trasaction receiving money, publickey, vout, amount(per block probably))
#(transacion, ((publickey, amount?, vout), amount per block))
# second_join = vout_f_join.join(block_f_join)
# secondjoin_format = second_join.map(lambda f: "{}, {}, {}, {}".format(f[0], f[1][0][0],f[1][0][1],f[1][1]))
# # trsaction, publickey, amount?, amount per block

for line in vout_f_join.takeSample(False, 3):
    print(line)

#secondjoin_format.repartition(1).saveAsTextFile("RansomewarePartC")

######################################### PART III ####################################################
# #Matchiing trasactions is coming from with out new VOUT
# def getRan(line):
#     try:
#         fields = line.split(',')
#         if len(fields) == 5:
#             float(fields[4])
#             return True
#         else:
#             return False
#
#     except:
#         return False
#
# block_receive = sc.textFile("RansomewarePartB")
# block_split = block_receive.filter(getRan).map(lambda l: l.split(','))
# block_f_join = block_split.map(lambda l: ((l[2]),(float(l[4]))))
# #(trasactions where money is going to from the randome key, amount per block)
# ######### Identifying publick keys receiving money #############################################
# ################ CHECK FOR PUBLICKEYS FOR TRSACTIONS ########################################
# vin_data = sc.textFile("/data/bitcoin/vin.csv")
# vin_split = vin_data.map(lambda l: l.split(','))
# vin_f_join = vin_split.map(lambda l: ((l[0]),(l[1],l[2])))
# # (trasaction receiving money, txhash(money is coming from), vout)
# third_join = vin_f_join.join(block_f_join)
# #(transaction, ((txhash-trsaction is coming from, vout), amount per block))
# thirdjoin_format = third_join.map(lambda f: "{}, {}, {}, {}".format(f[0], f[1][0][0],f[1][0][1],f[1][1]))
# # transactions, txhash-transaction money is coming from,vout, amount per block.
# for line in thirdjoin_format.takeSample(False, 3):
#     print(line)
#
# thirdjoin_format.repartition(1).saveAsTextFile("RansomewarePartD")
