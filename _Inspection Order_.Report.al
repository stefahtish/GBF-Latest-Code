report 50472 "Inspection Order"
{
    ApplicationArea = All;
    Caption = 'Inspection Order';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Inspection Order.rdl';

    dataset
    {
        dataitem("Inspection Header"; "Inspection Header")
        {
            RequestFilterFields = "Inspection No";

            column(InspectionNo_InspectionHeader; "Inspection No")
            {
            }
            column(InspectionDate_InspectionHeader; "Inspection Date")
            {
            }
            column(CompanyLogo; CompInfo.Picture)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(SupplierName_InspectionHeader; "Supplier Name")
            {
            }
            dataitem("Inspection Lines"; "Inspection Lines")
            {
                DataItemLink = "Inspection No"=field("Inspection No");

                column(ItemNo_InspectionLines; "Item No")
                {
                }
                column(Description_InspectionLines; Description)
                {
                }
                column(QuantityOrdered_InspectionLines; "Quantity Ordered")
                {
                }
                column(QuantityReceived_InspectionLines; "Quantity Received")
                {
                }
                column(InspectionDecision_InspectionLines; "Inspection Decision")
                {
                }
                column(Remarks_InspectionLines; Remarks)
                {
                }
                column(OrderNo_InspectionLines; "Order No")
                {
                }
            }
            dataitem(CommiteeMembers; "Commitee Member")
            {
                DataItemLink = "Tender No."=field("Tender No.");

                column(EmployeeNo_CommiteeMembers; "Employee No")
                {
                }
                column(Name_CommiteeMembers; Name)
                {
                }
                column(Role_CommiteeMembers; Role)
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInfo.get();
        CompInfo.CalcFields(Picture);
    end;
    var CompInfo: Record "Company Information";
}
