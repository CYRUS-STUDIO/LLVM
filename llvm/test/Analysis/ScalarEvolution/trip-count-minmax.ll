; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes='print<scalar-evolution>' -disable-output %s 2>&1 | FileCheck %s

; Tests for checking the trip multiple in loops where we cmp induction variables
; against Min/Max SCEVs

define void @nomulitply(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: 'nomulitply'
; CHECK-NEXT:  Classifying expressions for: @nomulitply
; CHECK-NEXT:    %cond = select i1 %cmp, i32 %a, i32 %b
; CHECK-NEXT:    --> (%a umin %b) U: full-set S: full-set
; CHECK-NEXT:    %i.08 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,2147483647) S: [0,2147483647) Exits: (-1 + (%a umin %b)) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw nsw i32 %i.08, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%for.body> U: [1,-2147483648) S: [1,-2147483648) Exits: (%a umin %b) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @nomulitply
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + (%a umin %b))
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 2147483646
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + (%a umin %b))
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (-1 + (%a umin %b))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
; No information about a or b. Trip multiple is 1.
; void nomulitple(unsigned a, unsigned b) {
;   int N = a < b ? a : b;
;   for (int i = 0; i < N; ++i) {
;     foo();
;   }
; }

entry:
  %cmp = icmp ult i32 %a, %b
  %cond = select i1 %cmp, i32 %a, i32 %b
  %cmp17 = icmp sgt i32 %cond, 0
  br i1 %cmp17, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw nsw i32 %i.08, 1
  %exitcond.not = icmp eq i32 %inc, %cond
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @umin(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: 'umin'
; CHECK-NEXT:  Classifying expressions for: @umin
; CHECK-NEXT:    %mul = shl i32 %a, 1
; CHECK-NEXT:    --> (2 * %a) U: [0,-1) S: [-2147483648,2147483647)
; CHECK-NEXT:    %mul1 = shl i32 %b, 2
; CHECK-NEXT:    --> (4 * %b) U: [0,-3) S: [-2147483648,2147483645)
; CHECK-NEXT:    %cond = select i1 %cmp, i32 %mul, i32 %mul1
; CHECK-NEXT:    --> ((2 * %a) umin (4 * %b)) U: [0,-3) S: [-2147483648,2147483647)
; CHECK-NEXT:    %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,2147483647) S: [0,2147483647) Exits: (-1 + ((2 * %a) umin (4 * %b))) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw nsw i32 %i.011, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%for.body> U: [1,-2147483648) S: [1,-2147483648) Exits: ((2 * %a) umin (4 * %b)) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @umin
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + ((2 * %a) umin (4 * %b)))
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 2147483646
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + ((2 * %a) umin (4 * %b)))
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (-1 + ((2 * %a) umin (4 * %b)))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
; void umin(unsigned a, unsigned b) {
;   a *= 2;
;   b *= 4;
;   int N = a < b ? a : b;
;   for (int i = 0; i < N; ++i) {
;     foo();
;   }
;  }

entry:
  %mul = shl i32 %a, 1
  %mul1 = shl i32 %b, 2
  %cmp = icmp ult i32 %mul, %mul1
  %cond = select i1 %cmp, i32 %mul, i32 %mul1
  %cmp210 = icmp sgt i32 %cond, 0
  br i1 %cmp210, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw nsw i32 %i.011, 1
  %exitcond.not = icmp eq i32 %inc, %cond
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}


define void @umax(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: 'umax'
; CHECK-NEXT:  Classifying expressions for: @umax
; CHECK-NEXT:    %mul = shl i32 %a, 1
; CHECK-NEXT:    --> (2 * %a) U: [0,-1) S: [-2147483648,2147483647)
; CHECK-NEXT:    %mul1 = shl i32 %b, 2
; CHECK-NEXT:    --> (4 * %b) U: [0,-3) S: [-2147483648,2147483645)
; CHECK-NEXT:    %cond = select i1 %cmp, i32 %mul, i32 %mul1
; CHECK-NEXT:    --> ((2 * %a) umax (4 * %b)) U: [0,-1) S: [-2147483648,2147483647)
; CHECK-NEXT:    %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,-2147483648) S: [0,-2147483648) Exits: (-1 + ((2 * %a) umax (4 * %b))) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw nsw i32 %i.011, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-1) S: [1,-1) Exits: ((2 * %a) umax (4 * %b)) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @umax
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + ((2 * %a) umax (4 * %b)))
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is -3
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + ((2 * %a) umax (4 * %b)))
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (-1 + ((2 * %a) umax (4 * %b)))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %for.body: Trip multiple is 2
;

; void umax(unsigned a, unsigned b) {
;   a *= 2;
;   b *= 4;
;   int N = a > b ? a : b;
;   for (int i = 0; i < N; ++i) {
;     foo();
;   }
; }

entry:
  %mul = shl i32 %a, 1
  %mul1 = shl i32 %b, 2
  %cmp = icmp ugt i32 %mul, %mul1
  %cond = select i1 %cmp, i32 %mul, i32 %mul1
  %cmp210 = icmp sgt i32 %cond, 0
  br i1 %cmp210, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw nsw i32 %i.011, 1
  %exitcond.not = icmp eq i32 %inc, %cond
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @smin(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: 'smin'
; CHECK-NEXT:  Classifying expressions for: @smin
; CHECK-NEXT:    %mul = shl nsw i32 %a, 1
; CHECK-NEXT:    --> (2 * %a)<nsw> U: [0,-1) S: [-2147483648,2147483647)
; CHECK-NEXT:    %mul1 = shl nsw i32 %b, 2
; CHECK-NEXT:    --> (4 * %b)<nsw> U: [0,-3) S: [-2147483648,2147483645)
; CHECK-NEXT:    %cond = select i1 %cmp, i32 %mul, i32 %mul1
; CHECK-NEXT:    --> ((2 * %a)<nsw> smin (4 * %b)<nsw>) U: [0,-1) S: [-2147483648,2147483645)
; CHECK-NEXT:    %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,2147483647) S: [0,2147483647) Exits: (-1 + ((2 * %a)<nsw> smin (4 * %b)<nsw>)) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw nsw i32 %i.011, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%for.body> U: [1,-2147483648) S: [1,-2147483648) Exits: ((2 * %a)<nsw> smin (4 * %b)<nsw>) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @smin
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + ((2 * %a)<nsw> smin (4 * %b)<nsw>))
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 2147483646
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + ((2 * %a)<nsw> smin (4 * %b)<nsw>))
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (-1 + ((2 * %a)<nsw> smin (4 * %b)<nsw>))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
; void smin(signed a, signed b) {
;   a *= 2;
;   b *= 4;
;   int N = a < b ? a : b;
;   for (int i = 0; i < N; ++i) {
;     foo();
;   }
; }

entry:
  %mul = shl nsw i32 %a, 1
  %mul1 = shl nsw i32 %b, 2
  %cmp = icmp slt i32 %mul, %mul1
  %cond = select i1 %cmp, i32 %mul, i32 %mul1
  %cmp210 = icmp sgt i32 %cond, 0
  br i1 %cmp210, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw nsw i32 %i.011, 1
  %exitcond.not = icmp eq i32 %inc, %cond
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @smax(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: 'smax'
; CHECK-NEXT:  Classifying expressions for: @smax
; CHECK-NEXT:    %mul = shl nsw i32 %a, 1
; CHECK-NEXT:    --> (2 * %a)<nsw> U: [0,-1) S: [-2147483648,2147483647)
; CHECK-NEXT:    %mul1 = shl nsw i32 %b, 2
; CHECK-NEXT:    --> (4 * %b)<nsw> U: [0,-3) S: [-2147483648,2147483645)
; CHECK-NEXT:    %cond = select i1 %cmp, i32 %mul, i32 %mul1
; CHECK-NEXT:    --> ((2 * %a)<nsw> smax (4 * %b)<nsw>) U: [0,-1) S: [-2147483648,2147483647)
; CHECK-NEXT:    %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,-2147483648) S: [0,-2147483648) Exits: (-1 + ((2 * %a)<nsw> smax (4 * %b)<nsw>)) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw nsw i32 %i.011, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%for.body> U: [1,-1) S: [1,-1) Exits: ((2 * %a)<nsw> smax (4 * %b)<nsw>) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @smax
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + ((2 * %a)<nsw> smax (4 * %b)<nsw>))
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is -3
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + ((2 * %a)<nsw> smax (4 * %b)<nsw>))
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (-1 + ((2 * %a)<nsw> smax (4 * %b)<nsw>))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %for.body: Trip multiple is 2
;
; void smax(signed a, signed b) {
;   a *= 2;
;   b *= 4;
;   int N = a > b ? a : b;
;   for (int i = 0; i < N; ++i) {
;     foo();
;   }
; }

entry:
  %mul = shl nsw i32 %a, 1
  %mul1 = shl nsw i32 %b, 2
  %cmp = icmp sgt i32 %mul, %mul1
  %cond = select i1 %cmp, i32 %mul, i32 %mul1
  %cmp210 = icmp sgt i32 %cond, 0
  br i1 %cmp210, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw nsw i32 %i.011, 1
  %exitcond.not = icmp eq i32 %inc, %cond
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define void @umin_seq2(i32 %n, i32 %m) {
; CHECK-LABEL: 'umin_seq2'
; CHECK-NEXT:  Classifying expressions for: @umin_seq2
; CHECK-NEXT:    %n.2 = shl nsw i32 %n, 1
; CHECK-NEXT:    --> (2 * %n) U: [0,-1) S: [-2147483648,2147483647)
; CHECK-NEXT:    %m.2 = shl nsw i32 %m, 4
; CHECK-NEXT:    --> (16 * %m) U: [0,-15) S: [-2147483648,2147483633)
; CHECK-NEXT:    %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%loop> U: [0,-2147483648) S: [0,-2147483648) Exits: ((-1 + (1 umax (2 * %n))) umin_seq (-1 + (1 umax (16 * %m)))) LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %i.next = add nuw nsw i32 %i, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><%loop> U: [1,-15) S: [1,-15) Exits: (1 + ((-1 + (1 umax (2 * %n))) umin_seq (-1 + (1 umax (16 * %m)))))<nuw> LoopDispositions: { %loop: Computable }
; CHECK-NEXT:    %cond = select i1 %cond_p0, i1 %cond_p1, i1 false
; CHECK-NEXT:    --> (%cond_p0 umin_seq %cond_p1) U: full-set S: full-set Exits: <<Unknown>> LoopDispositions: { %loop: Variant }
; CHECK-NEXT:  Determining loop execution counts for: @umin_seq2
; CHECK-NEXT:  Loop %loop: backedge-taken count is ((-1 + (1 umax (2 * %n))) umin_seq (-1 + (1 umax (16 * %m))))
; CHECK-NEXT:  Loop %loop: constant max backedge-taken count is -17
; CHECK-NEXT:  Loop %loop: symbolic max backedge-taken count is ((-1 + (1 umax (2 * %n))) umin_seq (-1 + (1 umax (16 * %m))))
; CHECK-NEXT:  Loop %loop: Predicated backedge-taken count is ((-1 + (1 umax (2 * %n))) umin_seq (-1 + (1 umax (16 * %m))))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %loop: Trip multiple is 1
;
; Can't find that trip multiple is 2 for this case of umin_seq
entry:
  %n.2 = shl nsw i32 %n, 1
  %m.2 = shl nsw i32 %m, 4
  br label %loop
loop:
  %i = phi i32 [0, %entry], [%i.next, %loop]
  tail call void (...) @foo() #2
  %i.next = add nuw nsw i32 %i, 1
  %cond_p0 = icmp ult i32 %i.next, %n.2
  %cond_p1 = icmp ult i32 %i.next, %m.2
  %cond = select i1 %cond_p0, i1 %cond_p1, i1 false
  br i1 %cond, label %loop, label %exit
exit:
  ret void
}

define void @umin-3and6(i32 noundef %a, i32 noundef %b) {
; CHECK-LABEL: 'umin-3and6'
; CHECK-NEXT:  Classifying expressions for: @umin-3and6
; CHECK-NEXT:    %mul = mul i32 %a, 3
; CHECK-NEXT:    --> (3 * %a) U: full-set S: full-set
; CHECK-NEXT:    %mul1 = mul i32 %b, 6
; CHECK-NEXT:    --> (6 * %b) U: [0,-1) S: [-2147483648,2147483647)
; CHECK-NEXT:    %cond = select i1 %cmp, i32 %mul, i32 %mul1
; CHECK-NEXT:    --> ((3 * %a) umin (6 * %b)) U: [0,-1) S: full-set
; CHECK-NEXT:    %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
; CHECK-NEXT:    --> {0,+,1}<nuw><nsw><%for.body> U: [0,2147483647) S: [0,2147483647) Exits: (-1 + ((3 * %a) umin (6 * %b))) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:    %inc = add nuw nsw i32 %i.011, 1
; CHECK-NEXT:    --> {1,+,1}<nuw><nsw><%for.body> U: [1,-2147483648) S: [1,-2147483648) Exits: ((3 * %a) umin (6 * %b)) LoopDispositions: { %for.body: Computable }
; CHECK-NEXT:  Determining loop execution counts for: @umin-3and6
; CHECK-NEXT:  Loop %for.body: backedge-taken count is (-1 + ((3 * %a) umin (6 * %b)))
; CHECK-NEXT:  Loop %for.body: constant max backedge-taken count is 2147483646
; CHECK-NEXT:  Loop %for.body: symbolic max backedge-taken count is (-1 + ((3 * %a) umin (6 * %b)))
; CHECK-NEXT:  Loop %for.body: Predicated backedge-taken count is (-1 + ((3 * %a) umin (6 * %b)))
; CHECK-NEXT:   Predicates:
; CHECK-NEXT:  Loop %for.body: Trip multiple is 1
;
; Trip multiple is 1 because we use GetMinTrailingZeros() to compute trip multiples.
; SCEV cannot compute that the trip multiple is 3.
; void umin(unsigned a, unsigned b) {
;   a *= 3;
;   b *= 6;
;   int N = a < b ? a : b;
;   for (int i = 0; i < N; ++i) {
;     foo();
;   }
;  }

entry:
  %mul = mul i32 %a, 3
  %mul1 = mul i32 %b, 6
  %cmp = icmp ult i32 %mul, %mul1
  %cond = select i1 %cmp, i32 %mul, i32 %mul1
  %cmp210 = icmp sgt i32 %cond, 0
  br i1 %cmp210, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry, %for.body
  %i.011 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  tail call void (...) @foo() #2
  %inc = add nuw nsw i32 %i.011, 1
  %exitcond.not = icmp eq i32 %inc, %cond
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

declare void @foo(...) local_unnamed_addr #1