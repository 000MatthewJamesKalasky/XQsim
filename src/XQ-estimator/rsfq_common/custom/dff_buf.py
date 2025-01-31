import pandas as pd

name_list = []

def get_name(cn):
    global name_list
    for on in name_list:
        if cn in on:
            name = on
            break
    return name

def initial_setup(rsfqlib):
    global name_list
    cell_list = ["dfft", "splitt"]
    if "mitll" in rsfqlib:
        name_list = ["mitll_"+cn for cn in cell_list]
    else:
        raise Exception()
    return


def gen_dffbuf_netlist(data_bw, rsfqlib):
    initial_setup(rsfqlib)

    conn = None

    bd = dict()
    bd[get_name("split")] = (data_bw-1)
    bd[get_name("dff")] = data_bw 
    bd = pd.DataFrame(bd, index=[0])
    return conn, bd
