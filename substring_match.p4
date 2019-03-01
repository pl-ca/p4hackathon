/* -*- P4_16 -*- */
#include <core.p4>
#include <v1model.p4>

/*************************************************************************
*********************** H E A D E R S  ***********************************
*************************************************************************/

typedef bit<64> string_t;

typedef bit<9>  egressSpec_t;

header hdrtype_t {
    bit<8> input_or_internal;
}
header input_t {
    string_t strA;
    string_t strB;
}

header internal_t {
    bit<32> iterator_l;
    bit<32> iterator_r;
    bit<32> highest_count;
    string_t matrix_l0;
    string_t matrix_l1;
    string_t matrix_l2;
    string_t matrix_l3;
    string_t matrix_l4;
    string_t matrix_l5;
    string_t matrix_l6;
    string_t matrix_l7;
}

struct metadata {
    /* empty */
    bit<8>  charA;
    bit<8>  charB;
}

struct headers {
    hdrtype_t  type_header;
    input_t    input_header;
    internal_t internal_header;
}

/*************************************************************************
*********************** P A R S E R  ***********************************
*************************************************************************/

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        packet.extract(hdr.type_header);        
        transition select(hdr.type_header.input_or_internal) {
            0: parse_input;
            1: parse_internal;
            default: parse_reject;
        }
    }

    state parse_internal {
        packet.extract(hdr.internal_header);
        transition parse_input;
    }

    state parse_input {
        packet.extract(hdr.input_header);
        transition accept;
    }

    state parse_reject {
        transition accept;
    }

}

/*************************************************************************
************   C H E C K S U M    V E R I F I C A T I O N   *************
*************************************************************************/

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {   
    apply {  }
}


/*************************************************************************
**************  I N G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

    action get_strA_char0(){
        meta.charA = hdr.input_header.strA[63:56];
    }

    action get_strA_char1(){
        meta.charA = hdr.input_header.strA[55:48];
    }

    action get_strA_char2(){
        meta.charA = hdr.input_header.strA[47:40];
    }

    action get_strA_char3(){
       meta.charA = hdr.input_header.strA[39:32];
    }

    action get_strA_char4(){
        meta.charA = hdr.input_header.strA[31:24];
    }

    action get_strA_char5(){
        meta.charA = hdr.input_header.strA[23:16];
    }

    action get_strA_char6(){
        meta.charA = hdr.input_header.strA[15:8];
    }

    action get_strA_char7(){
       meta.charA = hdr.input_header.strA[7:0];
    }

    action get_strB_char0(){
        meta.charB = hdr.input_header.strB[63:56];
    }

    action get_strB_char1(){
        meta.charB = hdr.input_header.strB[55:48];
    }

    action get_strB_char2(){
        meta.charB = hdr.input_header.strB[47:40];
    }

    action get_strB_char3(){
        meta.charB = hdr.input_header.strB[39:32];
    }

    action get_strB_char4(){
        meta.charB = hdr.input_header.strB[31:24];
    }

    action get_strB_char5(){
        meta.charB = hdr.input_header.strB[23:16];
    }

    action get_strB_char6(){
        meta.charB = hdr.input_header.strB[15:8];
    }

    action get_strB_char7(){
        meta.charB = hdr.input_header.strB[7:0];
    }

    table get_strA_char{
        key = {
            hdr.internal_header.iterator_r : exact;
        }
        actions = {
            get_strA_char0;
            get_strA_char1;
            get_strA_char2;
            get_strA_char3;
            get_strA_char4;
            get_strA_char5;
            get_strA_char6;
            get_strA_char7;
        }
    }

    table get_strB_char{
        key = {
            hdr.internal_header.iterator_l: exact;
        }
        actions = {
            get_strB_char0;
            get_strB_char1;
            get_strB_char2;
            get_strB_char3;
            get_strB_char4;
            get_strB_char5;
            get_strB_char6;
            get_strB_char7;
        }
    }


    action do_recirculate(){
        recirculate(meta);
    }
    action do_output(){
        //standard_metadata.egress_spec = port;        
    }

    action convert_to_output(){
        hdr.internal_header.setInvalid();
        hdr.type_header.input_or_internal = 0;
        do_output();
    }

/*     action update_indices (){
        hdr.internal_header.iterator_r = hdr.internal_header.iterator_r + 1;
        if(hdr.internal_header.iterator_r == 8){
            hdr.internal_header.iterator_r = 0;
            hdr.internal_header.iterator_l = hdr.internal_header.iterator_l + 1;
        }
        if (hdr.internal_header.iterator_l < 8){
            do_recirculate();
        } else {
            convert_to_output();
        }
    } */
/* 
    action convert_to_internal(){
        hdr.internal_header.iterator_l = 0;
        hdr.internal_header.iterator_r = 0;
        hdr.internal_header.highest_count = 0;
        hdr.internal_header.matrix_l0 = 0;
        hdr.internal_header.matrix_l1 = 0;
        hdr.internal_header.matrix_l2 = 0;
        hdr.internal_header.matrix_l3 = 0;
        hdr.internal_header.matrix_l4 = 0;
        hdr.internal_header.matrix_l5 = 0;
        hdr.internal_header.matrix_l6 = 0;
        hdr.internal_header.matrix_l7 = 0;

        do_recirculate();
    }
 */
   
    action dummy_for_rp_test_a(){
        meta.charB = 0;
    }

    table dummy_for_rp_test{
        key = {
            meta.charA : exact;
            meta.charB : exact;
        }
        actions = {
            dummy_for_rp_test_a;
        }
    }

    apply {
        hdr.internal_header.iterator_r = 1;
        hdr.internal_header.iterator_l = 2;
        get_strA_char.apply();
        get_strB_char.apply();

//        dummy_for_rp_test.apply();

        if(hdr.type_header.input_or_internal == 0){
        //   convert_to_internal();
        } else {
        //    update_indices();
        }
    }
}

/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply {  }
}

/*************************************************************************
*************   C H E C K S U M    C O M P U T A T I O N   **************
*************************************************************************/

control MyComputeChecksum(inout headers  hdr, inout metadata meta) {
     apply {
    }
}

/*************************************************************************
***********************  D E P A R S E R  *******************************
*************************************************************************/

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.type_header);
        packet.emit(hdr.internal_header);
        packet.emit(hdr.input_header);
    }
}

/*************************************************************************
***********************  S W I T C H  *******************************
*************************************************************************/

V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;
