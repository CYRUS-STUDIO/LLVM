; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck --check-prefix=IC %s
; RUN: opt < %s -passes='instcombine,sroa' -S | FileCheck --check-prefix=IC_SROA %s

; rdar://6417724
; Instcombine shouldn't do anything to this function that prevents promoting the allocas inside it.

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128"
target triple = "i386-apple-darwin9.6"

%"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >" = type { ptr }
%"struct.std::_Vector_base<int,std::allocator<int> >" = type { %"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl" }
%"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl" = type { ptr, ptr, ptr }
%"struct.std::bidirectional_iterator_tag" = type <{ i8 }>
%"struct.std::forward_iterator_tag" = type <{ i8 }>
%"struct.std::input_iterator_tag" = type <{ i8 }>
%"struct.std::random_access_iterator_tag" = type <{ i8 }>
%"struct.std::vector<int,std::allocator<int> >" = type { %"struct.std::_Vector_base<int,std::allocator<int> >" }

define ptr @_Z3fooRSt6vectorIiSaIiEE(ptr %X) {
; IC-LABEL: @_Z3fooRSt6vectorIiSaIiEE(
; IC-NEXT:  entry:
; IC-NEXT:    [[__FIRST_ADDR_I_I:%.*]] = alloca %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", align 8
; IC-NEXT:    [[__LAST_ADDR_I_I:%.*]] = alloca %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", align 8
; IC-NEXT:    [[TMP0:%.*]] = alloca i32, align 4
; IC-NEXT:    store i32 42, ptr [[TMP0]], align 4
; IC-NEXT:    [[TMP1:%.*]] = getelementptr %"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", ptr [[X:%.*]], i32 0, i32 1
; IC-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[TMP1]], align 4
; IC-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[X]], align 4
; IC-NEXT:    store ptr [[TMP3]], ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    store ptr [[TMP2]], ptr [[__LAST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP4:%.*]] = ptrtoint ptr [[TMP2]] to i32
; IC-NEXT:    [[TMP5:%.*]] = ptrtoint ptr [[TMP3]] to i32
; IC-NEXT:    [[TMP6:%.*]] = sub i32 [[TMP4]], [[TMP5]]
; IC-NEXT:    [[TMP7:%.*]] = ashr i32 [[TMP6]], 4
; IC-NEXT:    br label [[BB12_I_I:%.*]]
; IC:       bb.i.i:
; IC-NEXT:    [[TMP8:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP9:%.*]] = load i32, ptr [[TMP8]], align 4
; IC-NEXT:    [[TMP10:%.*]] = load i32, ptr [[TMP0]], align 4
; IC-NEXT:    [[TMP11:%.*]] = icmp eq i32 [[TMP9]], [[TMP10]]
; IC-NEXT:    br i1 [[TMP11]], label [[BB1_I_I:%.*]], label [[BB2_I_I:%.*]]
; IC:       bb1.i.i:
; IC-NEXT:    [[TMP12:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT:%.*]]
; IC:       bb2.i.i:
; IC-NEXT:    [[TMP13:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP14:%.*]] = getelementptr i32, ptr [[TMP13]], i32 1
; IC-NEXT:    store ptr [[TMP14]], ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP15:%.*]] = load i32, ptr [[TMP14]], align 4
; IC-NEXT:    [[TMP16:%.*]] = load i32, ptr [[TMP0]], align 4
; IC-NEXT:    [[TMP17:%.*]] = icmp eq i32 [[TMP15]], [[TMP16]]
; IC-NEXT:    br i1 [[TMP17]], label [[BB4_I_I:%.*]], label [[BB5_I_I:%.*]]
; IC:       bb4.i.i:
; IC-NEXT:    [[TMP18:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC:       bb5.i.i:
; IC-NEXT:    [[TMP19:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP20:%.*]] = getelementptr i32, ptr [[TMP19]], i32 1
; IC-NEXT:    store ptr [[TMP20]], ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP21:%.*]] = load i32, ptr [[TMP20]], align 4
; IC-NEXT:    [[TMP22:%.*]] = load i32, ptr [[TMP0]], align 4
; IC-NEXT:    [[TMP23:%.*]] = icmp eq i32 [[TMP21]], [[TMP22]]
; IC-NEXT:    br i1 [[TMP23]], label [[BB7_I_I:%.*]], label [[BB8_I_I:%.*]]
; IC:       bb7.i.i:
; IC-NEXT:    [[TMP24:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC:       bb8.i.i:
; IC-NEXT:    [[TMP25:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP26:%.*]] = getelementptr i32, ptr [[TMP25]], i32 1
; IC-NEXT:    store ptr [[TMP26]], ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP27:%.*]] = load i32, ptr [[TMP26]], align 4
; IC-NEXT:    [[TMP28:%.*]] = load i32, ptr [[TMP0]], align 4
; IC-NEXT:    [[TMP29:%.*]] = icmp eq i32 [[TMP27]], [[TMP28]]
; IC-NEXT:    br i1 [[TMP29]], label [[BB10_I_I:%.*]], label [[BB11_I_I:%.*]]
; IC:       bb10.i.i:
; IC-NEXT:    [[TMP30:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC:       bb11.i.i:
; IC-NEXT:    [[TMP31:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP32:%.*]] = getelementptr i32, ptr [[TMP31]], i32 1
; IC-NEXT:    store ptr [[TMP32]], ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP33:%.*]] = add nsw i32 [[__TRIP_COUNT_0_I_I:%.*]], -1
; IC-NEXT:    br label [[BB12_I_I]]
; IC:       bb12.i.i:
; IC-NEXT:    [[__TRIP_COUNT_0_I_I]] = phi i32 [ [[TMP7]], [[ENTRY:%.*]] ], [ [[TMP33]], [[BB11_I_I]] ]
; IC-NEXT:    [[TMP34:%.*]] = icmp sgt i32 [[__TRIP_COUNT_0_I_I]], 0
; IC-NEXT:    br i1 [[TMP34]], label [[BB_I_I:%.*]], label [[BB13_I_I:%.*]]
; IC:       bb13.i.i:
; IC-NEXT:    [[TMP35:%.*]] = load ptr, ptr [[__LAST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP36:%.*]] = ptrtoint ptr [[TMP35]] to i32
; IC-NEXT:    [[TMP37:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP38:%.*]] = ptrtoint ptr [[TMP37]] to i32
; IC-NEXT:    [[TMP39:%.*]] = sub i32 [[TMP36]], [[TMP38]]
; IC-NEXT:    [[TMP40:%.*]] = ashr i32 [[TMP39]], 2
; IC-NEXT:    switch i32 [[TMP40]], label [[BB26_I_I:%.*]] [
; IC-NEXT:      i32 1, label [[BB22_I_I:%.*]]
; IC-NEXT:      i32 2, label [[BB18_I_I:%.*]]
; IC-NEXT:      i32 3, label [[BB14_I_I:%.*]]
; IC-NEXT:    ]
; IC:       bb14.i.i:
; IC-NEXT:    [[TMP41:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP42:%.*]] = load i32, ptr [[TMP41]], align 4
; IC-NEXT:    [[TMP43:%.*]] = load i32, ptr [[TMP0]], align 4
; IC-NEXT:    [[TMP44:%.*]] = icmp eq i32 [[TMP42]], [[TMP43]]
; IC-NEXT:    br i1 [[TMP44]], label [[BB16_I_I:%.*]], label [[BB17_I_I:%.*]]
; IC:       bb16.i.i:
; IC-NEXT:    [[TMP45:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC:       bb17.i.i:
; IC-NEXT:    [[TMP46:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP47:%.*]] = getelementptr i32, ptr [[TMP46]], i32 1
; IC-NEXT:    store ptr [[TMP47]], ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[BB18_I_I]]
; IC:       bb18.i.i:
; IC-NEXT:    [[TMP48:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP49:%.*]] = load i32, ptr [[TMP48]], align 4
; IC-NEXT:    [[TMP50:%.*]] = load i32, ptr [[TMP0]], align 4
; IC-NEXT:    [[TMP51:%.*]] = icmp eq i32 [[TMP49]], [[TMP50]]
; IC-NEXT:    br i1 [[TMP51]], label [[BB20_I_I:%.*]], label [[BB21_I_I:%.*]]
; IC:       bb20.i.i:
; IC-NEXT:    [[TMP52:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC:       bb21.i.i:
; IC-NEXT:    [[TMP53:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP54:%.*]] = getelementptr i32, ptr [[TMP53]], i32 1
; IC-NEXT:    store ptr [[TMP54]], ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[BB22_I_I]]
; IC:       bb22.i.i:
; IC-NEXT:    [[TMP55:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP56:%.*]] = load i32, ptr [[TMP55]], align 4
; IC-NEXT:    [[TMP57:%.*]] = load i32, ptr [[TMP0]], align 4
; IC-NEXT:    [[TMP58:%.*]] = icmp eq i32 [[TMP56]], [[TMP57]]
; IC-NEXT:    br i1 [[TMP58]], label [[BB24_I_I:%.*]], label [[BB25_I_I:%.*]]
; IC:       bb24.i.i:
; IC-NEXT:    [[TMP59:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC:       bb25.i.i:
; IC-NEXT:    [[TMP60:%.*]] = load ptr, ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    [[TMP61:%.*]] = getelementptr i32, ptr [[TMP60]], i32 1
; IC-NEXT:    store ptr [[TMP61]], ptr [[__FIRST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[BB26_I_I]]
; IC:       bb26.i.i:
; IC-NEXT:    [[TMP62:%.*]] = load ptr, ptr [[__LAST_ADDR_I_I]], align 4
; IC-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC:       _ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit:
; IC-NEXT:    [[DOT0_0_I_I:%.*]] = phi ptr [ [[TMP62]], [[BB26_I_I]] ], [ [[TMP59]], [[BB24_I_I]] ], [ [[TMP52]], [[BB20_I_I]] ], [ [[TMP45]], [[BB16_I_I]] ], [ [[TMP30]], [[BB10_I_I]] ], [ [[TMP24]], [[BB7_I_I]] ], [ [[TMP18]], [[BB4_I_I]] ], [ [[TMP12]], [[BB1_I_I]] ]
; IC-NEXT:    br label [[RETURN:%.*]]
; IC:       return:
; IC-NEXT:    ret ptr [[DOT0_0_I_I]]
;
; IC_SROA-LABEL: @_Z3fooRSt6vectorIiSaIiEE(
; IC_SROA-NEXT:  entry:
; IC_SROA-NEXT:    [[TMP0:%.*]] = getelementptr %"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", ptr [[X:%.*]], i32 0, i32 1
; IC_SROA-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[TMP0]], align 4
; IC_SROA-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[X]], align 4
; IC_SROA-NEXT:    [[TMP3:%.*]] = ptrtoint ptr [[TMP1]] to i32
; IC_SROA-NEXT:    [[TMP4:%.*]] = ptrtoint ptr [[TMP2]] to i32
; IC_SROA-NEXT:    [[TMP5:%.*]] = sub i32 [[TMP3]], [[TMP4]]
; IC_SROA-NEXT:    [[TMP6:%.*]] = ashr i32 [[TMP5]], 4
; IC_SROA-NEXT:    br label [[BB12_I_I:%.*]]
; IC_SROA:       bb.i.i:
; IC_SROA-NEXT:    [[TMP7:%.*]] = load i32, ptr [[__FIRST_ADDR_I_I_SROA_0_0:%.*]], align 4
; IC_SROA-NEXT:    [[TMP8:%.*]] = icmp eq i32 [[TMP7]], 42
; IC_SROA-NEXT:    br i1 [[TMP8]], label [[BB1_I_I:%.*]], label [[BB2_I_I:%.*]]
; IC_SROA:       bb1.i.i:
; IC_SROA-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT:%.*]]
; IC_SROA:       bb2.i.i:
; IC_SROA-NEXT:    [[TMP9:%.*]] = getelementptr i32, ptr [[__FIRST_ADDR_I_I_SROA_0_0]], i32 1
; IC_SROA-NEXT:    [[TMP10:%.*]] = load i32, ptr [[TMP9]], align 4
; IC_SROA-NEXT:    [[TMP11:%.*]] = icmp eq i32 [[TMP10]], 42
; IC_SROA-NEXT:    br i1 [[TMP11]], label [[BB4_I_I:%.*]], label [[BB5_I_I:%.*]]
; IC_SROA:       bb4.i.i:
; IC_SROA-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC_SROA:       bb5.i.i:
; IC_SROA-NEXT:    [[TMP12:%.*]] = getelementptr i32, ptr [[TMP9]], i32 1
; IC_SROA-NEXT:    [[TMP13:%.*]] = load i32, ptr [[TMP12]], align 4
; IC_SROA-NEXT:    [[TMP14:%.*]] = icmp eq i32 [[TMP13]], 42
; IC_SROA-NEXT:    br i1 [[TMP14]], label [[BB7_I_I:%.*]], label [[BB8_I_I:%.*]]
; IC_SROA:       bb7.i.i:
; IC_SROA-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC_SROA:       bb8.i.i:
; IC_SROA-NEXT:    [[TMP15:%.*]] = getelementptr i32, ptr [[TMP12]], i32 1
; IC_SROA-NEXT:    [[TMP16:%.*]] = load i32, ptr [[TMP15]], align 4
; IC_SROA-NEXT:    [[TMP17:%.*]] = icmp eq i32 [[TMP16]], 42
; IC_SROA-NEXT:    br i1 [[TMP17]], label [[BB10_I_I:%.*]], label [[BB11_I_I:%.*]]
; IC_SROA:       bb10.i.i:
; IC_SROA-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC_SROA:       bb11.i.i:
; IC_SROA-NEXT:    [[TMP18:%.*]] = getelementptr i32, ptr [[TMP15]], i32 1
; IC_SROA-NEXT:    [[TMP19:%.*]] = add nsw i32 [[__TRIP_COUNT_0_I_I:%.*]], -1
; IC_SROA-NEXT:    br label [[BB12_I_I]]
; IC_SROA:       bb12.i.i:
; IC_SROA-NEXT:    [[__FIRST_ADDR_I_I_SROA_0_0]] = phi ptr [ [[TMP2]], [[ENTRY:%.*]] ], [ [[TMP18]], [[BB11_I_I]] ]
; IC_SROA-NEXT:    [[__TRIP_COUNT_0_I_I]] = phi i32 [ [[TMP6]], [[ENTRY]] ], [ [[TMP19]], [[BB11_I_I]] ]
; IC_SROA-NEXT:    [[TMP20:%.*]] = icmp sgt i32 [[__TRIP_COUNT_0_I_I]], 0
; IC_SROA-NEXT:    br i1 [[TMP20]], label [[BB_I_I:%.*]], label [[BB13_I_I:%.*]]
; IC_SROA:       bb13.i.i:
; IC_SROA-NEXT:    [[TMP21:%.*]] = ptrtoint ptr [[TMP1]] to i32
; IC_SROA-NEXT:    [[TMP22:%.*]] = ptrtoint ptr [[__FIRST_ADDR_I_I_SROA_0_0]] to i32
; IC_SROA-NEXT:    [[TMP23:%.*]] = sub i32 [[TMP21]], [[TMP22]]
; IC_SROA-NEXT:    [[TMP24:%.*]] = ashr i32 [[TMP23]], 2
; IC_SROA-NEXT:    switch i32 [[TMP24]], label [[BB26_I_I:%.*]] [
; IC_SROA-NEXT:      i32 1, label [[BB22_I_I:%.*]]
; IC_SROA-NEXT:      i32 2, label [[BB18_I_I:%.*]]
; IC_SROA-NEXT:      i32 3, label [[BB14_I_I:%.*]]
; IC_SROA-NEXT:    ]
; IC_SROA:       bb14.i.i:
; IC_SROA-NEXT:    [[TMP25:%.*]] = load i32, ptr [[__FIRST_ADDR_I_I_SROA_0_0]], align 4
; IC_SROA-NEXT:    [[TMP26:%.*]] = icmp eq i32 [[TMP25]], 42
; IC_SROA-NEXT:    br i1 [[TMP26]], label [[BB16_I_I:%.*]], label [[BB17_I_I:%.*]]
; IC_SROA:       bb16.i.i:
; IC_SROA-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC_SROA:       bb17.i.i:
; IC_SROA-NEXT:    [[TMP27:%.*]] = getelementptr i32, ptr [[__FIRST_ADDR_I_I_SROA_0_0]], i32 1
; IC_SROA-NEXT:    br label [[BB18_I_I]]
; IC_SROA:       bb18.i.i:
; IC_SROA-NEXT:    [[__FIRST_ADDR_I_I_SROA_0_1:%.*]] = phi ptr [ [[TMP27]], [[BB17_I_I]] ], [ [[__FIRST_ADDR_I_I_SROA_0_0]], [[BB13_I_I]] ]
; IC_SROA-NEXT:    [[TMP28:%.*]] = load i32, ptr [[__FIRST_ADDR_I_I_SROA_0_1]], align 4
; IC_SROA-NEXT:    [[TMP29:%.*]] = icmp eq i32 [[TMP28]], 42
; IC_SROA-NEXT:    br i1 [[TMP29]], label [[BB20_I_I:%.*]], label [[BB21_I_I:%.*]]
; IC_SROA:       bb20.i.i:
; IC_SROA-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC_SROA:       bb21.i.i:
; IC_SROA-NEXT:    [[TMP30:%.*]] = getelementptr i32, ptr [[__FIRST_ADDR_I_I_SROA_0_1]], i32 1
; IC_SROA-NEXT:    br label [[BB22_I_I]]
; IC_SROA:       bb22.i.i:
; IC_SROA-NEXT:    [[__FIRST_ADDR_I_I_SROA_0_2:%.*]] = phi ptr [ [[TMP30]], [[BB21_I_I]] ], [ [[__FIRST_ADDR_I_I_SROA_0_0]], [[BB13_I_I]] ]
; IC_SROA-NEXT:    [[TMP31:%.*]] = load i32, ptr [[__FIRST_ADDR_I_I_SROA_0_2]], align 4
; IC_SROA-NEXT:    [[TMP32:%.*]] = icmp eq i32 [[TMP31]], 42
; IC_SROA-NEXT:    br i1 [[TMP32]], label [[BB24_I_I:%.*]], label [[BB25_I_I:%.*]]
; IC_SROA:       bb24.i.i:
; IC_SROA-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC_SROA:       bb25.i.i:
; IC_SROA-NEXT:    [[TMP33:%.*]] = getelementptr i32, ptr [[__FIRST_ADDR_I_I_SROA_0_2]], i32 1
; IC_SROA-NEXT:    br label [[BB26_I_I]]
; IC_SROA:       bb26.i.i:
; IC_SROA-NEXT:    br label [[_ZST4FINDIN9__GNU_CXX17__NORMAL_ITERATORIPIST6VECTORIISAIIEEEEIET_S7_S7_RKT0__EXIT]]
; IC_SROA:       _ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit:
; IC_SROA-NEXT:    [[DOT0_0_I_I:%.*]] = phi ptr [ [[TMP1]], [[BB26_I_I]] ], [ [[__FIRST_ADDR_I_I_SROA_0_2]], [[BB24_I_I]] ], [ [[__FIRST_ADDR_I_I_SROA_0_1]], [[BB20_I_I]] ], [ [[__FIRST_ADDR_I_I_SROA_0_0]], [[BB16_I_I]] ], [ [[TMP15]], [[BB10_I_I]] ], [ [[TMP12]], [[BB7_I_I]] ], [ [[TMP9]], [[BB4_I_I]] ], [ [[__FIRST_ADDR_I_I_SROA_0_0]], [[BB1_I_I]] ]
; IC_SROA-NEXT:    br label [[RETURN:%.*]]
; IC_SROA:       return:
; IC_SROA-NEXT:    ret ptr [[DOT0_0_I_I]]
;
entry:
  %0 = alloca %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >"
  %__first_addr.i.i = alloca %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >"
  %__last_addr.i.i = alloca %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >"
  %unnamed_arg.i = alloca %"struct.std::bidirectional_iterator_tag", align 8
  %1 = alloca %"struct.std::bidirectional_iterator_tag"
  %__first_addr.i = alloca %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >"
  %2 = alloca %"struct.std::bidirectional_iterator_tag"
  %3 = alloca %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >"
  %4 = alloca i32
  %"alloca point" = bitcast i32 0 to i32
  store i32 42, ptr %4, align 4
  %5 = getelementptr %"struct.std::vector<int,std::allocator<int> >", ptr %X, i32 0, i32 0
  %6 = getelementptr %"struct.std::_Vector_base<int,std::allocator<int> >", ptr %5, i32 0, i32 0
  %7 = getelementptr %"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", ptr %6, i32 0, i32 1
  %8 = load ptr, ptr %7, align 4
  %9 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %3, i32 0, i32 0
  store ptr %8, ptr %9, align 4
  %10 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %3, i32 0, i32 0
  %11 = load ptr, ptr %10, align 4
  %tmp2.i = ptrtoint ptr %11 to i32
  %tmp1.i = inttoptr i32 %tmp2.i to ptr
  %tmp3 = ptrtoint ptr %tmp1.i to i32
  %tmp2 = inttoptr i32 %tmp3 to ptr
  %12 = getelementptr %"struct.std::vector<int,std::allocator<int> >", ptr %X, i32 0, i32 0
  %13 = getelementptr %"struct.std::_Vector_base<int,std::allocator<int> >", ptr %12, i32 0, i32 0
  %14 = getelementptr %"struct.std::_Vector_base<int,std::allocator<int> >::_Vector_impl", ptr %13, i32 0, i32 0
  %15 = load ptr, ptr %14, align 4
  %16 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %0, i32 0, i32 0
  store ptr %15, ptr %16, align 4
  %17 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %0, i32 0, i32 0
  %18 = load ptr, ptr %17, align 4
  %tmp2.i17 = ptrtoint ptr %18 to i32
  %tmp1.i18 = inttoptr i32 %tmp2.i17 to ptr
  %tmp8 = ptrtoint ptr %tmp1.i18 to i32
  %tmp6 = inttoptr i32 %tmp8 to ptr
  %19 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i, i32 0, i32 0
  store ptr %tmp6, ptr %19
  %20 = load i8, ptr %1, align 1
  %21 = or i8 %20, 0
  %22 = or i8 %21, 0
  %23 = or i8 %22, 0
  store i8 0, ptr %2, align 1
  %elt.i = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i, i32 0, i32 0
  %val.i = load ptr, ptr %elt.i
  call void @llvm.memcpy.p0.p0.i64(ptr %unnamed_arg.i, ptr %2, i64 1, i1 false)
  %24 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  store ptr %val.i, ptr %24
  %25 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__last_addr.i.i, i32 0, i32 0
  store ptr %tmp2, ptr %25
  %26 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__last_addr.i.i, i32 0, i32 0
  %27 = load ptr, ptr %26, align 4
  %28 = ptrtoint ptr %27 to i32
  %29 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %30 = load ptr, ptr %29, align 4
  %31 = ptrtoint ptr %30 to i32
  %32 = sub i32 %28, %31
  %33 = ashr i32 %32, 2
  %34 = ashr i32 %33, 2
  br label %bb12.i.i

bb.i.i:                                           ; preds = %bb12.i.i
  %35 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %36 = load ptr, ptr %35, align 4
  %37 = load i32, ptr %36, align 4
  %38 = load i32, ptr %4, align 4
  %39 = icmp eq i32 %37, %38
  %40 = zext i1 %39 to i8
  %toBool.i.i = icmp ne i8 %40, 0
  br i1 %toBool.i.i, label %bb1.i.i, label %bb2.i.i

bb1.i.i:                                          ; preds = %bb.i.i
  %41 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %42 = load ptr, ptr %41, align 4
  br label %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit

bb2.i.i:                                          ; preds = %bb.i.i
  %43 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %44 = load ptr, ptr %43, align 4
  %45 = getelementptr i32, ptr %44, i64 1
  %46 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  store ptr %45, ptr %46, align 4
  %47 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %48 = load ptr, ptr %47, align 4
  %49 = load i32, ptr %48, align 4
  %50 = load i32, ptr %4, align 4
  %51 = icmp eq i32 %49, %50
  %52 = zext i1 %51 to i8
  %toBool3.i.i = icmp ne i8 %52, 0
  br i1 %toBool3.i.i, label %bb4.i.i, label %bb5.i.i

bb4.i.i:                                          ; preds = %bb2.i.i
  %53 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %54 = load ptr, ptr %53, align 4
  br label %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit

bb5.i.i:                                          ; preds = %bb2.i.i
  %55 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %56 = load ptr, ptr %55, align 4
  %57 = getelementptr i32, ptr %56, i64 1
  %58 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  store ptr %57, ptr %58, align 4
  %59 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %60 = load ptr, ptr %59, align 4
  %61 = load i32, ptr %60, align 4
  %62 = load i32, ptr %4, align 4
  %63 = icmp eq i32 %61, %62
  %64 = zext i1 %63 to i8
  %toBool6.i.i = icmp ne i8 %64, 0
  br i1 %toBool6.i.i, label %bb7.i.i, label %bb8.i.i

bb7.i.i:                                          ; preds = %bb5.i.i
  %65 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %66 = load ptr, ptr %65, align 4
  br label %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit

bb8.i.i:                                          ; preds = %bb5.i.i
  %67 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %68 = load ptr, ptr %67, align 4
  %69 = getelementptr i32, ptr %68, i64 1
  %70 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  store ptr %69, ptr %70, align 4
  %71 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %72 = load ptr, ptr %71, align 4
  %73 = load i32, ptr %72, align 4
  %74 = load i32, ptr %4, align 4
  %75 = icmp eq i32 %73, %74
  %76 = zext i1 %75 to i8
  %toBool9.i.i = icmp ne i8 %76, 0
  br i1 %toBool9.i.i, label %bb10.i.i, label %bb11.i.i

bb10.i.i:                                         ; preds = %bb8.i.i
  %77 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %78 = load ptr, ptr %77, align 4
  br label %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit

bb11.i.i:                                         ; preds = %bb8.i.i
  %79 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %80 = load ptr, ptr %79, align 4
  %81 = getelementptr i32, ptr %80, i64 1
  %82 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  store ptr %81, ptr %82, align 4
  %83 = sub i32 %__trip_count.0.i.i, 1
  br label %bb12.i.i

bb12.i.i:                                         ; preds = %bb11.i.i, %entry
  %__trip_count.0.i.i = phi i32 [ %34, %entry ], [ %83, %bb11.i.i ]
  %84 = icmp sgt i32 %__trip_count.0.i.i, 0
  br i1 %84, label %bb.i.i, label %bb13.i.i

bb13.i.i:                                         ; preds = %bb12.i.i
  %85 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__last_addr.i.i, i32 0, i32 0
  %86 = load ptr, ptr %85, align 4
  %87 = ptrtoint ptr %86 to i32
  %88 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %89 = load ptr, ptr %88, align 4
  %90 = ptrtoint ptr %89 to i32
  %91 = sub i32 %87, %90
  %92 = ashr i32 %91, 2
  switch i32 %92, label %bb26.i.i [
  i32 1, label %bb22.i.i
  i32 2, label %bb18.i.i
  i32 3, label %bb14.i.i
  ]

bb14.i.i:                                         ; preds = %bb13.i.i
  %93 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %94 = load ptr, ptr %93, align 4
  %95 = load i32, ptr %94, align 4
  %96 = load i32, ptr %4, align 4
  %97 = icmp eq i32 %95, %96
  %98 = zext i1 %97 to i8
  %toBool15.i.i = icmp ne i8 %98, 0
  br i1 %toBool15.i.i, label %bb16.i.i, label %bb17.i.i

bb16.i.i:                                         ; preds = %bb14.i.i
  %99 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %100 = load ptr, ptr %99, align 4
  br label %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit

bb17.i.i:                                         ; preds = %bb14.i.i
  %101 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %102 = load ptr, ptr %101, align 4
  %103 = getelementptr i32, ptr %102, i64 1
  %104 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  store ptr %103, ptr %104, align 4
  br label %bb18.i.i

bb18.i.i:                                         ; preds = %bb17.i.i, %bb13.i.i
  %105 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %106 = load ptr, ptr %105, align 4
  %107 = load i32, ptr %106, align 4
  %108 = load i32, ptr %4, align 4
  %109 = icmp eq i32 %107, %108
  %110 = zext i1 %109 to i8
  %toBool19.i.i = icmp ne i8 %110, 0
  br i1 %toBool19.i.i, label %bb20.i.i, label %bb21.i.i

bb20.i.i:                                         ; preds = %bb18.i.i
  %111 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %112 = load ptr, ptr %111, align 4
  br label %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit

bb21.i.i:                                         ; preds = %bb18.i.i
  %113 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %114 = load ptr, ptr %113, align 4
  %115 = getelementptr i32, ptr %114, i64 1
  %116 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  store ptr %115, ptr %116, align 4
  br label %bb22.i.i

bb22.i.i:                                         ; preds = %bb21.i.i, %bb13.i.i
  %117 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %118 = load ptr, ptr %117, align 4
  %119 = load i32, ptr %118, align 4
  %120 = load i32, ptr %4, align 4
  %121 = icmp eq i32 %119, %120
  %122 = zext i1 %121 to i8
  %toBool23.i.i = icmp ne i8 %122, 0
  br i1 %toBool23.i.i, label %bb24.i.i, label %bb25.i.i

bb24.i.i:                                         ; preds = %bb22.i.i
  %123 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %124 = load ptr, ptr %123, align 4
  br label %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit

bb25.i.i:                                         ; preds = %bb22.i.i
  %125 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  %126 = load ptr, ptr %125, align 4
  %127 = getelementptr i32, ptr %126, i64 1
  %128 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__first_addr.i.i, i32 0, i32 0
  store ptr %127, ptr %128, align 4
  br label %bb26.i.i

bb26.i.i:                                         ; preds = %bb25.i.i, %bb13.i.i
  %129 = getelementptr %"struct.__gnu_cxx::__normal_iterator<int*,std::vector<int, std::allocator<int> > >", ptr %__last_addr.i.i, i32 0, i32 0
  %130 = load ptr, ptr %129, align 4
  br label %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit

_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit: ; preds = %bb26.i.i, %bb24.i.i, %bb20.i.i, %bb16.i.i, %bb10.i.i, %bb7.i.i, %bb4.i.i, %bb1.i.i
  %.0.0.i.i = phi ptr [ %130, %bb26.i.i ], [ %124, %bb24.i.i ], [ %112, %bb20.i.i ], [ %100, %bb16.i.i ], [ %78, %bb10.i.i ], [ %66, %bb7.i.i ], [ %54, %bb4.i.i ], [ %42, %bb1.i.i ]
  %tmp2.i.i = ptrtoint ptr %.0.0.i.i to i32
  %tmp1.i.i = inttoptr i32 %tmp2.i.i to ptr
  %tmp4.i = ptrtoint ptr %tmp1.i.i to i32
  %tmp3.i = inttoptr i32 %tmp4.i to ptr
  %tmp8.i = ptrtoint ptr %tmp3.i to i32
  %tmp6.i = inttoptr i32 %tmp8.i to ptr
  %tmp12 = ptrtoint ptr %tmp6.i to i32
  %tmp10 = inttoptr i32 %tmp12 to ptr
  %tmp16 = ptrtoint ptr %tmp10 to i32
  br label %return

return:                                           ; preds = %_ZSt4findIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiET_S7_S7_RKT0_.exit
  %tmp14 = inttoptr i32 %tmp16 to ptr
  ret ptr %tmp14
}

declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind