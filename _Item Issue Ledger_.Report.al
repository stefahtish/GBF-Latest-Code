report 50129 "Item Issue Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemIssueLedger.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = WHERE("Entry Type" = FILTER("Negative Adjmt." | Sale));
                RequestFilterFields = "Posting Date", "Global Dimension 1 Code", "Global Dimension 2 Code";

                column(Company_Name; CompanyInfo.Name)
                {
                }
                column(Address; CompanyInfo.Address)
                {
                }
                column(Picture; CompanyInfo.Picture)
                {
                }
                column(Post_Code; CompanyInfo."Post Code")
                {
                }
                column(Posting_Date; "Item Ledger Entry"."Posting Date")
                {
                }
                column(Item_No; "Item Ledger Entry"."Item No.")
                {
                }
                column(Document_No; "Item Ledger Entry"."Document No.")
                {
                }
                column(Description; "Item Ledger Entry".Description)
                {
                }
                column(ItemName; ItemName)
                {
                }
                column(Global_Dimension_1_Code; "Item Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(Global_Dimension_2_Code; "Item Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(Dept_Name; GetDeptName("Item Ledger Entry"."Global Dimension 2 Code"))
                {
                }
                column(Quantity; "Item Ledger Entry".Quantity)
                {
                }
                column(Cost_Amount_Expected; "Item Ledger Entry"."Cost Amount (Expected)")
                {
                }
                column(Unit_Cost; UnitCost)
                {
                }
                column(Cost_Amount_Actual; "Item Ledger Entry"."Cost Amount (Actual)")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    UnitCost := "Item Ledger Entry"."Cost Amount (Actual)" / "Item Ledger Entry".Quantity;
                    if Item.Get("Item Ledger Entry"."Item No.") then ItemName := Item.Description;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        UnitCost: Decimal;
        ItemName: Text[200];

    procedure GetDeptName(DimCode: Code[20]): Text
    var
        Dimension: Record "Dimension Value";
    begin
        Dimension.Reset;
        Dimension.SetRange(Code, DimCode);
        if Dimension.Find('-') then exit(Dimension.Name);
    end;
}
