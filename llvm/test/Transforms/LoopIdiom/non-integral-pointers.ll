; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=loop-idiom < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128-ni:4"
target triple = "x86_64-unknown-linux-gnu"

; LIR'ing stores of pointers with address space 3 is fine, since
; they're integral pointers.
define void @f_0(ptr %ptr) {
; CHECK-LABEL: @f_0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr align 4 [[PTR:%.*]], i8 0, i64 80000, i1 false)
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVAR:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVAR_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr ptr addrspace(3), ptr [[PTR]], i64 [[INDVAR]]
; CHECK-NEXT:    [[INDVAR_NEXT]] = add i64 [[INDVAR]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVAR_NEXT]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;

entry:
  br label %for.body

for.body:
  %indvar = phi i64 [ 0, %entry ], [ %indvar.next, %for.body ]
  %arrayidx = getelementptr ptr addrspace(3), ptr %ptr, i64 %indvar
  store ptr addrspace(3) null, ptr %arrayidx, align 4
  %indvar.next = add i64 %indvar, 1
  %exitcond = icmp eq i64 %indvar.next, 10000
  br i1 %exitcond, label %for.end, label %for.body

for.end:
  ret void
}

; LIR'ing stores of pointers with address space 4 is not ok, since
; they're non-integral pointers. NOTE: Zero is special value which
; can be converted, if we add said handling here, convert this test
; to use any non-null pointer.
define void @f_1(ptr %ptr) {
; CHECK-LABEL: @f_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVAR:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVAR_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr ptr addrspace(4), ptr [[PTR:%.*]], i64 [[INDVAR]]
; CHECK-NEXT:    store ptr addrspace(4) null, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INDVAR_NEXT]] = add i64 [[INDVAR]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVAR_NEXT]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;

entry:
  br label %for.body

for.body:
  %indvar = phi i64 [ 0, %entry ], [ %indvar.next, %for.body ]
  %arrayidx = getelementptr ptr addrspace(4), ptr %ptr, i64 %indvar
  store ptr addrspace(4) null, ptr %arrayidx, align 4
  %indvar.next = add i64 %indvar, 1
  %exitcond = icmp eq i64 %indvar.next, 10000
  br i1 %exitcond, label %for.end, label %for.body

for.end:
  ret void
}

; Same as previous case, but vector of non-integral pointers
define void @f_2(ptr %ptr) {
; CHECK-LABEL: @f_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVAR:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVAR_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr ptr addrspace(4), ptr [[PTR:%.*]], i64 [[INDVAR]]
; CHECK-NEXT:    store <2 x ptr addrspace(4)> zeroinitializer, ptr [[ARRAYIDX]], align 8
; CHECK-NEXT:    [[INDVAR_NEXT]] = add i64 [[INDVAR]], 2
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVAR_NEXT]], 10000
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %indvar = phi i64 [ 0, %entry ], [ %indvar.next, %for.body ]
  %arrayidx = getelementptr ptr addrspace(4), ptr %ptr, i64 %indvar
  store <2 x ptr addrspace(4)> zeroinitializer, ptr %arrayidx, align 8
  %indvar.next = add i64 %indvar, 2
  %exitcond = icmp eq i64 %indvar.next, 10000
  br i1 %exitcond, label %for.end, label %for.body

for.end:
  ret void
}