tableextension 50107 AnalysisTableExt extends "Analysis View Budget Entry"
{
    fields
    {
        field(50000; Encumberance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE(Account=FIELD("G/L Account No."), "Commitment Date"=FIELD("Date Filter"), "Global Dimension 1"=FIELD("Dimension 1 Value Code"), "Global Dimension 2"=FIELD("Dimension 2 Value Code"), "Commitment Type"=FILTER(Encumberance|"Encumberance Reversal"), "Dimension Set ID"=FIELD("Dimension Set ID")));
        }
        field(50001; Commitments; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE(Account=FIELD("G/L Account No."), "Commitment Date"=FIELD("Date Filter"), "Global Dimension 1"=FIELD("Dimension 1 Value Code"), "Global Dimension 2"=FIELD("Dimension 2 Value Code"), "Commitment Type"=FILTER(Commitment|"Commitment Reversal"), "Dimension Set ID"=FIELD("Dimension Set ID")));
        }
        field(50002; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50003; Actuals; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("G/L Account No."), "Global Dimension 1 Code"=FIELD("Dimension 1 Value Code"), "Global Dimension 2 Code"=FIELD("Dimension 2 Value Code"), "Posting Date"=FIELD("Date Filter"), "Dimension Set ID"=FIELD("Dimension Set ID")));
        }
        field(50004; "Dimension Set ID"; Integer)
        {
            TableRelation = "Dimension Set Entry";
        }
    }
}
