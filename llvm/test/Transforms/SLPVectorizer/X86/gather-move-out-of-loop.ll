; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=slp-vectorizer -slp-threshold=-100 -mtriple=x86_64-w64-windows-gnu < %s | FileCheck %s

define void @test(i16 %0) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  for.body92.preheader:
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x i16> <i16 0, i16 poison>, i16 [[TMP0:%.*]], i32 1
; CHECK-NEXT:    [[TMP2:%.*]] = sext <2 x i16> [[TMP1]] to <2 x i32>
; CHECK-NEXT:    [[TMP3:%.*]] = zext <2 x i16> [[TMP1]] to <2 x i32>
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <2 x i32> [[TMP2]], <2 x i32> [[TMP3]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x i32> [[TMP4]], <2 x i32> poison, <4 x i32> <i32 0, i32 poison, i32 1, i32 poison>
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <4 x i32> <i32 poison, i32 0, i32 poison, i32 0>, <4 x i32> [[TMP5]], <4 x i32> <i32 4, i32 1, i32 6, i32 3>
; CHECK-NEXT:    br label [[FOR_BODY92:%.*]]
; CHECK:       for.body92:
; CHECK-NEXT:    [[TMP7:%.*]] = add nsw <4 x i32> zeroinitializer, [[TMP6]]
; CHECK-NEXT:    store <4 x i32> [[TMP7]], ptr undef, align 8
; CHECK-NEXT:    br label [[FOR_BODY92]]
;
for.body92.preheader:
  br label %for.body92

for.body92:
  %conv177.i = sext i16 0 to i32
  %add178.i = add nsw i32 0, %conv177.i
  store i32 %add178.i, ptr undef, align 8
  %1 = zext i16 %0 to i32
  %sum_mvr_abs.i = getelementptr i32, ptr undef, i32 2
  %add182.i = add nsw i32 0, %1
  store i32 %add182.i, ptr %sum_mvr_abs.i, align 8
  %sum_mvc.i = getelementptr i32, ptr undef, i32 1
  %add184.i = add nsw i32 0, 0
  store i32 %add184.i, ptr %sum_mvc.i, align 4
  %sum_mvc_abs.i = getelementptr i32, ptr undef, i32 3
  %add188.i = add nsw i32 0, 0
  store i32 %add188.i, ptr %sum_mvc_abs.i, align 4
  br label %for.body92
}