; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

declare i1 @llvm.is.constant.i32(i32)

define void @test(ptr %bpf_prog_calc_tag___trans_tmp_3, i32 %0) {
; CHECK-LABEL: define void @test
; CHECK-SAME: (ptr [[BPF_PROG_CALC_TAG___TRANS_TMP_3:%.*]], i32 [[TMP0:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 true, label [[IF_ELSE_I:%.*]], label [[IF_THEN_I:%.*]]
; CHECK:       if.then.i:
; CHECK-NEXT:    br label [[__FSWAB64_EXIT:%.*]]
; CHECK:       if.else.i:
; CHECK-NEXT:    br label [[__FSWAB64_EXIT]]
; CHECK:       __fswab64.exit:
; CHECK-NEXT:    store i32 0, ptr [[BPF_PROG_CALC_TAG___TRANS_TMP_3]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %conv = zext i32 %0 to i64
  %1 = lshr i64 %conv, 32
  %conv1.i = trunc i64 %1 to i32
  %2 = call i1 @llvm.is.constant.i32(i32 %conv1.i)
  br i1 %2, label %if.else.i, label %if.then.i

if.then.i:                                        ; preds = %entry
  %3 = load volatile i32, ptr null, align 2147483648
  br label %__fswab64.exit

if.else.i:                                        ; preds = %entry
  %or.i = call i32 @llvm.fshl.i32(i32 %conv1.i, i32 0, i32 16)
  br label %__fswab64.exit

__fswab64.exit:                                   ; preds = %if.then.i, %if.else.i
  %t.0.i = phi i32 [ %or.i, %if.else.i ], [ %3, %if.then.i ]
  %shr2.i = lshr i32 %t.0.i, 1
  store i32 %shr2.i, ptr %bpf_prog_calc_tag___trans_tmp_3, align 4
  ret void
}

declare i32 @llvm.fshl.i32(i32, i32, i32)