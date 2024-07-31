report 50309 "LPO Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LPOBalances.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            RequestFilterFields = "Document Type", "Buy-from Vendor No.", "Document No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code";

            column(Comp_Name; CompanyInfo.Name)
            {
            }
            column(Comp_Address; CompanyInfo.Address)
            {
            }
            column(Comp_phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Comp_City; CompanyInfo.City)
            {
            }
            column(Comp_Logo; CompanyInfo.Picture)
            {
            }
            column(Comp_Post_Code; CompanyInfo."Post Code")
            {
            }
            column(Comp_Email; CompanyInfo."E-Mail")
            {
            }
            column(Comp_Website; CompanyInfo."Home Page")
            {
            }
            column(Order_Date; "Purchase Line"."Order Date")
            {
            }
            column(Buy_from_Vendor_No; "Purchase Line"."Buy-from Vendor No.")
            {
            }
            column(Description; "Purchase Line".Description)
            {
            }
            column(Document_No; "Purchase Line"."Document No.")
            {
            }
            column(Quantity; "Purchase Line".Quantity)
            {
            }
            column(Qty_to_Receive; "Purchase Line"."Qty. to Receive")
            {
            }
            column(Quantity_Received; "Purchase Line"."Quantity Received")
            {
            }
            column(Direct_Unit_Cost; "Purchase Line"."Direct Unit Cost")
            {
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
}
